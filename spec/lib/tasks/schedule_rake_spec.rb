# spec/lib/tasks/schedule_rake_spec.rb
require 'rails_helper'

RSpec.describe 'schedule' do
  include_context 'rake'

  describe 'destroy_pots' do
    let(:task_name) { 'schedule:destroy_pots' }

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

  describe 'notify_admins' do
    let!(:admin) { create(:user, :admin) }
    let(:task_name) { 'schedule:notify_admins' }

    its(:prerequisites) { should include('environment') }

    it 'it enqueues an update_email for admins' do
      expect { subject.invoke }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end

  describe 'contacts' do
    let(:task_name) { 'schedule:contacts' }

    its(:prerequisites) { should include('environment') }

    it 'it enqueues a FriendSyncWorker for 100 unsynced users' do
      expect { subject.invoke }.to change(FriendSyncWorker.jobs, :size).by(1)
    end
  end
end
