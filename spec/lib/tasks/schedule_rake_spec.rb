# spec/lib/tasks/schedule_rake_spec.rb
describe 'schedule:close_pots' do
  include_context 'rake'

  its(:prerequisites) { should include('environment') }

  it 'does nothing to open jars' do
    create_list(:jar, 2, :open)
    expect { subject.invoke }.to change { Jar.count }.by(0)
  end

  # it 'it closes ' do
  #   subject.invoke
  #   UsersReport.should have_received(:new).with(user_records)
  # end
end