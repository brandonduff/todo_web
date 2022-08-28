require "bundler/setup"
require "hackr"
require "zeitwerk"

loader = Zeitwerk::Loader.new
loader.push_dir("lib/")
loader.push_dir("lib/views")
loader.setup # ready!

module Todo
end
