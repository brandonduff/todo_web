module Todo
  module UseCases
    class Clear < UseCase
      def perform
        task_list = TaskListFetcher.new(notepad).tasks_for_day(notepad.read_current_day)
        task_list.clear
        notepad.write_todays_tasks(task_list)
      end

      attr_reader :notepad
    end
  end
end
