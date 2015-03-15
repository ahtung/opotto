namespace :smoke do
  desc 'Smoke test staging'
  task staging: :environment do
    `bundle exec cucumber`
  end

  desc 'Smoke test production'
  task production: :environment do
    `bundle exec cucumber`
  end
end
