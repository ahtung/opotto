namespace :smoke do
  desc 'Smoke test staging'
  task staging: :environment do
    REMOTE=TRUE bundle exec cucumber
  end

  desc 'Smoke test production'
  task production: :environment do

  end
end
