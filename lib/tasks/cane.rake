require 'cane/rake_task'

desc "Run cane to check quality metrics"
Cane::RakeTask.new(:quality) do |cane|
  cane.abc_max = 16
  cane.add_threshold 'coverage/.last_run.json', :>=, 96.3
  cane.no_style = true
end
