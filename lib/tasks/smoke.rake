namespace :smoke do
  desc 'Smoke test staging'
  task staging: :environment do
    begin
      system('RACK_ENV=staging bundle exec cucumber')
    rescue
      exit
    end
  end

  desc 'Smoke test production'
  task production: :environment do
    begin
      system('RACK_ENV=production bundle exec cucumber')
    rescue
      exit
    end
  end
end
