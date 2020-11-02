module Todo
  module UseCases
    class Promote < UseCase
      def perform(task)
        tasks = @persistence.read_tasks_for_day(@persistence.read_current_day)
        tasks.promote(TaskBuilder.new(task).build)
        @persistence.write_todays_tasks(tasks)
      end
    end
  end
end
