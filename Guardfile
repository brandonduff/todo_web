guard :minitest, zeus: true, bundler: false do
  notification :emacs

  watch(%r{^test/(.*)\/(.*)_test\.rb$})
  watch(%r{^lib/(.*/)?([^/]+)\.rb$})     { |m| 'test' }
  watch(%r{^test/test_helper\.rb$})      { 'test' }
end
