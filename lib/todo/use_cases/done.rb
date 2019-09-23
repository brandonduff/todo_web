module Todo
  module UseCases
    class Done

      def initialize(task=nil)
        @task_to_finish = task
      end

      def perform
        return "" unless task_to_finish

        task_list = todays_task_list
        done_task = task_list.done(task_to_finish)
        persistence.write_todays_tasks(task_list)
        present(done_task)
      end

      private

      def task_to_finish
        @task_to_finish || todays_task_list.unfinished_tasks.first
      end

      def todays_task_list
        TaskListFetcher.new(persistence).tasks_for_day(persistence.read_current_day)
      end

      def present(todo)
        todo.to_s
      end

      def persistence
        Persistence.new
      end
    end
  end
end
