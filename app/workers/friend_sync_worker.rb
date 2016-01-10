# FriendSyncWorker
class FriendSyncWorker
  include Sidekiq::Worker

  sidekiq_options retry: false
  sidekiq_options queue: 'friend_sync'

  # perform worker
  def perform(user_id)
    user = User.find(user_id)
    user.import_contacts
  end
end
