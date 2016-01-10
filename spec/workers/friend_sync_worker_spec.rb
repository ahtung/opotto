require 'rails_helper'

RSpec.describe FriendSyncWorker, type: :worker do
  it { expect(FriendSyncWorker).to be_processed_in :default }
  it { expect(FriendSyncWorker).to be_retryable false }

  xit 'should trigger import_contacts on user' do
    user = create(:user)
    expect(user).to receive(:import_contacts)
    FriendSyncWorker.perform_async(user.id)
  end

  it 'should function' do
    user = create(:user)
    expect { FriendSyncWorker.perform_async(user.id) }.to change(FriendSyncWorker.jobs, :size).by(1)
  end
end
