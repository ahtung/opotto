require 'rails_helper'

RSpec.describe FriendSyncWorker, type: :worker do
  it { expect(FriendSyncWorker).to be_processed_in :friend_sync }
  it { expect(FriendSyncWorker).to be_retryable false }

  before :all do
    Sidekiq::Testing.inline!
  end

  it 'should trigger import_contacts on user' do
    user_ids = create_list(:user, 2).map(&:id)
    ans = FriendSyncWorker.perform_async(user_ids)
    expect(ans).not_to be_nil
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
