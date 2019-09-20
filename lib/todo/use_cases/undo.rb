module Todo
  module UseCases
    class Undo

      def perform
        task_list = todays_task_list
        undone_task = task_list.undo
        persistence.write_todays_tasks(task_list)
        present(undone_task)
      end

      private

      def todays_task_list
        TaskListFetcher.new(persistence).tasks_for_day(persistence.read_current_day)
      end

      def persistence
        Persistence.new
      end

      def present(task)
        task.to_s
      end
    end
  end
end
