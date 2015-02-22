namespace :schedule do
  desc 'Auto closes pots'
  task pots: :environment do
    Jar.open.map(&:close)
  end

  desc 'Ended pots will be destroyed.'
  task destroy_pot: :environment do
    Jar.ended.map(&:destroy)
  end

end
