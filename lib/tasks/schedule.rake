namespace :schedule do
  desc 'Auto closes pots'
  task close_pots: :environment do
    Jar.closed.map(&:payout)
  end

  desc 'Ended pots will be destroyed.'
  task destroy_pots: :environment do
    Jar.ended.map(&:destroy)
  end
end
