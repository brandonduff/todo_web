module Todo
  class Task

    def initialize(task_or_description, done = false)
      if task_or_description.is_a?(self.class)
        @description = task_or_description.description
        @done = task_or_description.done?
      else
        @description = task_or_description
        @done = done
      end
    end

    def formatted_description
      done? ? '✓ ' + @description : @description
    end

    def done
      @done = true
      self
    end

    def undo
      @done = false
      self
    end

    def in_progress?
      !done?
    end

    def done?
      !!@done
    end

    def to_s
      formatted_description
    end

    def ==(other)
      other.description == description && other.done? == done?
    end

    attr_reader :description
  end
end
