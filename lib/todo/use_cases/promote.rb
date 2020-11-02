module Todo
  module UseCases
    class Promote
      def self.perform(task)
        new(persistence: Persistence.new).perform(task)
      end

      def initialize(persistence:)
        @persistence = persistence
      end

      def perform(task)
        tasks = @persistence.read_tasks_for_day(@persistence.read_current_day)
        tasks.promote(TaskBuilder.new(task).build)
        @persistence.write_todays_tasks(tasks)
      end
    end
  end
end
