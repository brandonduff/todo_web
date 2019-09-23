module Todo
  class TaskList
    include Enumerable

    def initialize(buffer = StringIO.new)
      @tasks = buffer.string.split("\n").map { |description| TaskBuilder.new(description).build }
    end

    def add_task(task)
      @tasks << task
    end

    def done(task_to_finish)
      update_task_in_list(task_to_finish, task_to_finish.done)
    end

    def undo(task_to_unfinish = @tasks.find(&:done?))
      return unless task_to_unfinish
      update_task_in_list(task_to_unfinish, task_to_unfinish.undo)
    end

    def clear
      @tasks = @tasks.reject(&:done?)
    end

    def to_s
      @tasks.map(&:to_s).join("\n")
    end

    def each(*args, &block)
      @tasks.each(*args, &block)
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

    private

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
