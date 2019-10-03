module Todo
  module UseCases
    class CreateTodo
      def initialize(todo_text, persistence: Persistence.new)
        @todo_text = todo_text
        @persistence = persistence
      end

      def perform
        task_list = persistence.read_tasks_for_day(persistence.read_current_day)
        task_list.add_task(TaskBuilder.new(@todo_text).build)
        persistence.write_todays_tasks(task_list)
      end

      attr_reader :persistence
    end
  end
end
