require "bundler/gem_tasks"
require 'cucumber'
require 'cucumber/rake/task'
require 'rake/testtask'

desc "Run tests"
Rake::TestTask.new do |t|
  t.libs << "test/"
  t.pattern = "test/**/*_test.rb"
end

desc 'Run features'
Cucumber::Rake::Task.new(:features) do |t|
  opts = "features --format progress -x"
  opts += " --tags #{ENV['TAGS']}" if ENV['TAGS']
  t.cucumber_opts =  opts
  t.fork = false
end

task :default => [:test, :features]
