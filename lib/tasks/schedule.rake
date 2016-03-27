namespace :schedule do
  desc 'Ended pots will be destroyed.'
  task destroy_pots: :environment do
    Pot.ended.map(&:destroy)
  end

  desc "Admin's will be notified"
  task notify_admins: :environment do
    AdminMailer.update_email.deliver_later
  end
end
