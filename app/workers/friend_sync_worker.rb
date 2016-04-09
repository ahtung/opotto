# FriendSyncWorker
class FriendSyncWorker
  include Sidekiq::Worker

  sidekiq_options retry: false
  sidekiq_options queue: 'friend_sync'

  # perform worker
  def perform(user_ids)
    users = User.find(user_ids)
    users.map(&:import_contacts)
  end
end
