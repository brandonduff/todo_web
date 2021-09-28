class Task
  attr_writer :list

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

  def move_up
    @list.move(self, :up)
  end

  def move_down
    @list.move(self, :down)
  end

  def in_progress?
    !done?
  end

  def done?
    @done
  end

  def ==(other)
    other.description == description && other.done? == done?
  end

  attr_reader :description
end
