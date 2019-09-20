module Todo
  module UseCases
    class CreateTodo
      def initialize(todo_text)
        @todo_text = todo_text
      end

      def perform
        task_list = persistence.read_tasks_for_day(persistence.read_current_day)
        task_list.add_task(TaskBuilder.new(@todo_text).build)
        persistence.write_todays_tasks(task_list)
      end

      def persistence
        Persistence.new
      end
    end
  end
end
