# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'todo_web/version'

Gem::Specification.new do |spec|
  spec.name          = "todo_web"
  spec.version       = TodoWeb::VERSION
  spec.authors       = ["Brandon Duff"]
  spec.email         = ["brandonduff17@gmail.com"]

  spec.summary       = %q{blah}
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables << 'todo'
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "capybara"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-doc"
  spec.add_development_dependency "rspec-mocks"
  spec.add_development_dependency "irb"
  spec.add_development_dependency "zeitwerk"
  spec.add_development_dependency "rack-test"
  spec.add_runtime_dependency "activesupport"
  spec.add_runtime_dependency "sinatra"
end
