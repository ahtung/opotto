namespace :schedule do
  desc "Ended pots will be destroyed."
  task destroy_pot: :environment do
    Jar.ended.map(&:destroy)
  end

end
