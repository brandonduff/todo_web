module Todo
  class TaskList
    def initialize(buffer=StringIO.new)
      @tasks = buffer.string.split("\n").map { |description| TaskBuilder.new(description).build }
    end

    def add_task(task)
      @tasks << task
    end

    def done
      if (first_unfinished_todo_position = @tasks.find_index(&:in_progress?))
        @tasks[first_unfinished_todo_position] = @tasks[first_unfinished_todo_position].done
      end
    end

    def undo
      if (first_done_position = @tasks.find_index(&:done?))
        @tasks[first_done_position] = @tasks[first_done_position].undo
      end
    end

    def clear
      @tasks = @tasks.reject(&:done?)
    end

    def to_s
      @tasks.map(&:to_s).join("\n")
    end

    def to_a
      @tasks
    end

    def concat(other_list)
      TaskList.new.tap do |task_list|
        to_a.each do |task|
          task_list.add_task(task)
        end

        other_list.to_a.each do |task|
          task_list.add_task(task)
        end
      end
    end

    def self.from_array(array)
      TaskList.new.tap do |task_list|
        array.each do |task|
          task_list.add_task(task)
        end
      end
    end

    def ==(other_list)
      @tasks.each_with_index do |task, index|
        return false unless task == other_list.tasks[index]
      end
      true
    end

    def unfinished_tasks
      TaskList.new.tap do |list|
        @tasks.select(&:in_progress?).each { |done_task| list.add_task(done_task) }
      end
    end

    protected

    attr_reader :tasks

  end
end
