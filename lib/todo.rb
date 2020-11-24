require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.push_dir('lib/views')
loader.setup # ready!

module Todo

end

