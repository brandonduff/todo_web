module Framework
  class Application
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