module Todo
  class TaskList
    include Enumerable

    def self.from_array(array)
      new.tap do |task_list|
        array.each do |task|
          task_list.add_task(task)
        end
      end
    end

    def initialize(buffer = StringIO.new)
      @tasks = buffer.string.split("\n").map { |description| TaskBuilder.new(description).build }
    end

    def add_task(task)
      return if include?(task)
      @tasks << task
    end

    alias_method :<<, :add_task

    def done(task_to_finish)
      update_task_in_list(task_to_finish, task_to_finish.done)
    end

    def undo(task_to_unfinish)
      update_task_in_list(task_to_unfinish, task_to_unfinish.undo)
    end

    def clear
      @tasks = @tasks.reject(&:done?)
    end

    def move(task, direction)
      return unless include?(task)

      task_index = @tasks.find_index(task)
      if direction == :up
        swap(task_index, task_index - 1)
      else
        swap(task_index, task_index + 1)
      end
    end

    def to_s
      @tasks.map(&:to_s).join("\n")
    end

    def each(*args, &block)
      @tasks.each(*args, &block)
    end

    def concat(other_list)
      from_array(to_a.concat(other_list.to_a))
    end

    def ==(other_list)
      @tasks.each_with_index do |task, index|
        return false unless task == other_list.tasks[index]
      end
      true
    end

    def unfinished_tasks
      from_array(@tasks.select(&:in_progress?))
    end

    def finished_tasks
      from_array(@tasks.select(&:done?))
    end

    def empty?
      tasks.empty?
    end

    protected

    attr_reader :tasks

    private

    def swap(first_index, second_index)
      self[first_index], self[second_index] = self[second_index], self[first_index]
    end

    def []=(index, value)
      @tasks[index % @tasks.length] = value
    end

    def [](index)
      @tasks[index % @tasks.length]
    end

    def from_array(array)
      self.class.from_array(array)
    end

    def update_task_in_list(from, to)
      @tasks = @tasks.map do |t|
        if t == from
          to
        else
          t
        end
      end

      to
    end
  end
end
