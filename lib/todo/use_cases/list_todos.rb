module Todo
  module UseCases
    class ListTodos
      def initialize(request)
        @request = request
        @presenter = request[:presenter] || ConsolePresenter.new
      end

      def perform
        current_day = DayFormatter.format(persistence.read_current_day)
        tasks = task_fetcher.tasks_for_day(current_day)

        if @request[:all]
          present(tasks)
        else
          present(tasks.unfinished_tasks)
        end
      end

      private

      def present(tasks)
        presenter.present(tasks.to_a)
      end

      def persistence
        Persistence.new
      end

      def task_fetcher
        fetcher = TaskListFetcher.new(persistence)
        if @request[:month]
          fetcher.for_month
        elsif @request[:week]
          fetcher.for_week
        else
          fetcher
        end
      end

      attr_reader :presenter

      class ConsolePresenter
        def present(tasks)
          tasks.to_a.map(&:to_s)
        end
      end
    end
  end
end
