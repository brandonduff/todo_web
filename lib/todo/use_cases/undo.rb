module Todo
  module UseCases
    class Undo < UseCase
      def perform
        task_list = todays_task_list
        task_to_unfinish = task_list.finished_tasks.first
        return "" unless task_to_unfinish

        undone_task = task_list.undo(task_to_unfinish)
        notepad.write_todays_tasks(task_list)
        present(undone_task)
      end

      private

      def todays_task_list
        TaskListFetcher.new(notepad).tasks_for_day(notepad.read_current_day)
      end

      def present(task)
        task.to_s
      end

      attr_reader :notepad
    end
  end
end
