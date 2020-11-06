module Todo
  module UseCases
    class Move < UseCase
      def perform(task, direction)
        tasks = @persistence.read_tasks_for_day(@persistence.read_current_day)
        tasks.move(TaskBuilder.new(task).build, direction)
        @persistence.write_todays_tasks(tasks)
      end
    end
  end
end
