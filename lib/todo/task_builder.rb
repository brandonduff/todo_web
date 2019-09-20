module Todo
  class TaskBuilder
    def initialize(description)
      @description = description
    end

    def build
      done = !@description.slice!('✓ ').nil?
      Task.new(@description, done)
    end
  end
end
