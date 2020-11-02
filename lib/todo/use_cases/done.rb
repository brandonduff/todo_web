module Todo
  module UseCases
    class Done
      def initialize(task=nil, persistence: Persistence.new)
        @task_to_finish = task
        @persistence = persistence
      end

      def perform
        return "" unless task_to_finish

        task_list = todays_task_list
        done_task = task_list.done(task_to_finish)
        persistence.write_todays_tasks(task_list)
        present(done_task)
      end

      private

      def task_to_finish
        if @task_to_finish
          Todo::Task.new(@task_to_finish)
        else
          todays_task_list.unfinished_tasks.first
        end
      end

      def todays_task_list
        TaskListFetcher.new(persistence).tasks_for_day(persistence.read_current_day)
      end

      def present(todo)
        todo.to_s
      end

      attr_reader :persistence
    end
  end
end
