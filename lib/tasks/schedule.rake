namespace :schedule do
  desc 'Ended pots will be destroyed.'
  task destroy_pots: :environment do
    Jar.ended.map(&:destroy)
  end
end
