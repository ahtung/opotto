# spec/lib/tasks/schedule_rake_spec.rb
describe 'schedule:close_pots' do
  include_context 'rake'

  its(:prerequisites) { should include('environment') }

  it 'does nothing to open jars' do
    open_jars = create_list(:jar, 2, :open)
    subject.invoke
    jar = open_jars.first
    jar.reload
    expect(jar.paid_at).to be_nil
  end

  it 'it pays out closed' do
    closed_jars = create_list(:jar, 2, :closed)
    subject.invoke
    jar = closed_jars.first
    jar.reload
    expect(jar.paid_at).not_to be_nil
  end

  it 'it sends an email on payout' do
    create(:jar, :closed)
    expect { subject.invoke }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end

describe 'schedule:destroy_pot' do
  include_context 'rake'

  its(:prerequisites) { should include('environment') }

  it 'does nothing to open jars' do
    create_list(:jar, 2, :open)
    expect { subject.invoke }.to change { Jar.count }.by(0)
  end

  it 'it destroys a week old closeds' do
    create_list(:jar, 2, :ended)
    expect { subject.invoke }.to change { Jar.count }.by(-2)
  end
end
