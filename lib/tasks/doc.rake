desc 'Run yard'
task doc: :environment do
    system('bundle exec yard')
end
