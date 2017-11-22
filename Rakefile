require "bundler/gem_tasks"
require 'cucumber'
require 'cucumber/rake/task'

desc 'Run features'
Cucumber::Rake::Task.new(:features) do |t|
  opts = "features --format progress -x"
  opts += " --tags #{ENV['TAGS']}" if ENV['TAGS']
  t.cucumber_opts =  opts
  t.fork = false
end

task :default => [:features]
