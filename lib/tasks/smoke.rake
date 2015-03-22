namespace :smoke do
  desc 'Smoke test staging'
  task staging: :environment do
    system('RACK_ENV=staging bundle exec cucumber')
  end

  desc 'Smoke test production'
  task production: :environment do
    system('RACK_ENV=production bundle exec cucumber')
  end
end
