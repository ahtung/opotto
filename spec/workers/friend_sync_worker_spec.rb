require 'rails_helper'
RSpec.describe FriendSyncWorker, type: :worker do
  xit { is_expected.to be_processed_in :default }
  xit { is_expected.to be_retryable false }

  xit '' do
  end
end
