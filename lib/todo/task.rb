module Todo
  class Task
    def initialize(task_or_description, done = false)
      @description = task_or_description
      @done = done
    end

    def formatted_description
      done? ? '✓ ' + @description : @description
    end

    def done
      @done = true
    end

    def undo
      @done = false
    end

    def in_progress?
      !done?
    end

    def done?
      !!@done
    end

    def ==(other)
      other.description == description && other.done? == done?
    end

    attr_reader :description
  end
end
