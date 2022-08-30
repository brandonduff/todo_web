guard :minitest, zeus: true, bundler: false do
  notification :emacs

  watch(%r{^test/(.*/)?([^/]+)\.rb$}) { |_m| "test" }
  watch(%r{^lib/(.*/)?([^/]+)\.rb$}) { |_m| "test" }
  watch(%r{^test/test_helper\.rb$}) { "test" }
end
