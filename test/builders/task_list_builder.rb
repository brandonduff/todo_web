require 'todo/task_list'
require 'todo/task'

module Todo
  class TaskListBuilder
    def initialize(task_args)
      @task_args = task_args
    end

    def build
      TaskList.new.tap do |task_list|
        @task_args.each do |task_arg|
          task_list.add_task(Task.new(task_arg[:description], task_arg[:done]))
        end
      end
    end
  end
end
