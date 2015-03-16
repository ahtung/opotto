namespace :smoke do
  desc 'Smoke test staging'
  task staging: :environment do
    system('bundle exec cucumber')
  end

  desc 'Smoke test production'
  task production: :environment do
    system('bundle exec cucumber')
  end
end
