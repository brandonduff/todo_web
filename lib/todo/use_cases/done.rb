module Todo
  module UseCases
    class Done

      def perform
        task_list = todays_task_list
        done_task = task_list.done
        persistence.write_todays_tasks(task_list)
        present(done_task)
      end

      private

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
