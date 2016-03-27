require 'rails_helper'

RSpec.describe FriendSyncWorker, type: :worker do
  it { expect(FriendSyncWorker).to be_processed_in :friend_sync }
  it { expect(FriendSyncWorker).to be_retryable false }

  before :all do
    Sidekiq::Testing.inline!
  end

  xit 'should trigger import_contacts on user' do
    user = create(:user)
    FriendSyncWorker.perform_async(user.id)
    user.reload
    expect(user.last_contact_sync_at).not_to be_nil
  end

  it 'should function' do
    user = create(:user)
    Sidekiq::Testing.fake! do
      expect { FriendSyncWorker.perform_async(user.id) }.to change(FriendSyncWorker.jobs, :size).by(1)
    end
  end

  after :all do
    Sidekiq::Testing.fake!
  end
end
