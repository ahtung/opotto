namespace :schedule do
  desc 'Ended pots will be destroyed.'
  task destroy_pots: :environment do
    #    :nocov:
    Pot.ended.map(&:destroy)
    #    :nocov:
  end

  desc "Admin's will be notified"
  task notify_admins: :environment do
    #    :nocov:
    AdminMailer.update_email.deliver_later
    #    :nocov:
  end

  desc "Sync google contacts"
  task contacts: :environment do
    #    :nocov:
    user_ids = User.unsynced_for_a_while.limit(100).pluck(:id)
    FriendSyncWorker.perform_async(user_ids)
    #    :nocov:
  end
end
