desc 'Run test suite'
task test: :environment do
  Rake::Task['spec'].invoke
  Rake::Task['features'].invoke
end
