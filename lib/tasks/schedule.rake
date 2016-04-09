namespace :schedule do
  desc 'Ended pots will be destroyed.'
  task destroy_pots: :environment do
    Pot.ended.map(&:destroy)
  end

  desc "Admin's will be notified"
  task notify_admins: :environment do
    AdminMailer.update_email.deliver_later
  end

  desc "Sync google contacts"
  task contacts: :environment do
    user_ids = User.unsynced_for_a_while.limit(100).pluck(:id)
    FriendSyncWorker.perform_async(user_ids)
  end
end
