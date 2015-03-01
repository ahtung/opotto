# FriendSyncWorker
class FriendSyncWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  # perform worker
  def perform(user_id)
    user = User.find(user_id)
    user.import_contacts
  end
end
