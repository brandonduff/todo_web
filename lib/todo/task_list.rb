module Todo
  class TaskList
    include Enumerable
    extend Forwardable

    def_delegators :@tasks, :each, :empty?

    def self.from_array(array)
      new.tap do |task_list|
        array.each do |task|
          task_list.add_task(task)
        end
      end
    end

    def initialize
      @tasks = []
    end

    def add_task(task)
      return if include?(task)
      @tasks << task
      task.list = self
    end

    alias_method :<<, :add_task

    def done(task_to_finish)
      on_matching_task(task_to_finish, &:done)
    end

    def undo(task_to_unfinish)
      on_matching_task(task_to_unfinish, &:undo)
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
      @tasks.map(&:formatted_description).join("\n")
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

    protected

    attr_reader :tasks

    private

    def on_matching_task(candidate)
      task = @tasks.find { |task| task == candidate }
      yield task if task
      task
    end

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
  end
end
