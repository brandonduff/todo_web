module Todo
  module UseCases
    class Clear < UseCase
      def perform
        task_list = TaskListFetcher.new(persistence).tasks_for_day(persistence.read_current_day)
        task_list.clear
        persistence.write_todays_tasks(task_list)
      end

      attr_reader :persistence
    end
  end
end
