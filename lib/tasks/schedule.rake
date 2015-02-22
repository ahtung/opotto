namespace :schedule do
  desc 'Auto closes pots'
  task pots: :environment do
    Pot.open.map(&:close)
  end
end
