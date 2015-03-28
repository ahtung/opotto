desc 'Run rubocop'
task style: :environment do
  Rake::Task['rubocop'].invoke
end
