require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.push_dir('lib/views')
loader.push_dir('lib/framework')
loader.setup # ready!

module Todo

end