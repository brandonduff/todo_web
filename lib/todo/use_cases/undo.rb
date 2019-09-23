module Todo
  module UseCases
    class Undo

      def perform
        task_list = todays_task_list
        task_to_unfinish = task_list.finished_tasks.first
        return "" unless task_to_unfinish

        undone_task = task_list.undo(task_to_unfinish)
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
