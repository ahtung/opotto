require 'cane/rake_task'

desc "Run cane to check quality metrics"
Cane::RakeTask.new(:quality) do |cane|
  cane.abc_max = 14
  cane.add_threshold 'coverage/.last_run.json', :>=, 74
  cane.no_style = true
  cane.abc_exclude = %w(Foo::Bar#some_method)
end