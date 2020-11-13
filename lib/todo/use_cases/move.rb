module Todo
  module UseCases
    class Move < UseCase
      def perform(task, direction)
        tasks = @notepad.read_tasks_for_day(@notepad.read_current_day)
        tasks.move(TaskBuilder.new(task).build, direction)
        @notepad.write_todays_tasks(tasks)
      end
    end
  end
end
