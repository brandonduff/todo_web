require 'rake/testtask'

desc "Run tests"
Rake::TestTask.new do |t|
  t.libs << "test/"
  t.pattern = "test/**/*_test.rb"
end

task :default => [:test]
