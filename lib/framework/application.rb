require 'sinatra/base'

module Framework
  class Application
    def self.run(component_class)
      continuations = ContinuationDictionary.new
      instance = new(continuations)
      instance.register_root(component_class.new)
      app = Sinatra.new { get('/') { instance.call } }
      app.run!
    end

    def initialize(continuations)
      @continuations = continuations
    end

    def register_root(component)
      @root = component
    end

    def call(action = nil)
      @continuations[action].call if action
      @root.render(continuation_dictionary: @continuations)
    end
  end
end