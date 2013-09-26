require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)
task :default => :spec

desc "Open an irb session preloaded with this library"
task :console do
    exec "bundle exec irb -I lib -r keyword_extractor"
end

