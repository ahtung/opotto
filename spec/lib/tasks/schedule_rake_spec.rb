# spec/lib/tasks/schedule_rake_spec.rb
describe 'schedule:close_pots' do
  include_context 'rake'

  its(:prerequisites) { should include('environment') }

  it 'does nothing to open jars' do
    create_list(:jar, 2, :open)
    expect { subject.invoke }.to change { Jar.count }.by(0)
  end

  it 'it pays out closed' do
    create_list(:jar, 2, :closed)
    expect { subject.invoke }.to change { Jar.count }.by(2)
  end
end