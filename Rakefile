require "rake/testtask"
require "standard/rake"

desc "Run tests"
Rake::TestTask.new do |t|
  t.libs << "test/"
  t.pattern = "test/**/*_test.rb"
end

task default: [:test, "standard:fix"]
