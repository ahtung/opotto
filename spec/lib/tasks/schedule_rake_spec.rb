# spec/lib/tasks/schedule_rake_spec.rb
RSpec.describe 'schedule:destroy_pots' do
  include_context 'rake'

  its(:prerequisites) { should include('environment') }

  it 'does nothing to open pots' do
    create_list(:pot, 2, :open)
    expect { subject.invoke }.to change { Pot.count }.by(0)
  end

  it 'it destroys a week old closeds' do
    create_list(:pot, 2, :ended)
    expect { subject.invoke }.to change { Pot.count }.by(-2)
  end
end
