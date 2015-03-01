require 'rails_helper'

RSpec.describe FriendSyncWorker, type: :worker do

  it { expect(FriendSyncWorker).to be_processed_in :default }
  it { expect(FriendSyncWorker).to be_retryable false }

  xit 'should trigger import_ontacts on user' do
    user = create(:user)
    Sidekiq::Testing.inline! do
      FriendSyncWorker.perform_async(user.id)
      expect(user).to receive(:import_contacts)
    end
  end

  it 'should function' do
    user = create(:user)
    expect { FriendSyncWorker.perform_async(user.id) }.to change(FriendSyncWorker.jobs, :size).by(1)
  end
end
