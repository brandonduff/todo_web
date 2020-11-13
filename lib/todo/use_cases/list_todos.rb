module Todo
  module UseCases
    class ListTodos
      def initialize(request)
        @request = request
        @presenter = request[:presenter] || ConsolePresenter.new
        @notepad = request[:notepad] || Notepad.new
      end

      def perform
        current_day = DayFormatter.format(notepad.read_current_day)
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

      def task_fetcher
        fetcher = TaskListFetcher.new(notepad)
        if @request[:month]
          fetcher.for_month
        elsif @request[:week]
          fetcher.for_week
        else
          fetcher
        end
      end

      attr_reader :presenter, :notepad

      class ConsolePresenter
        def present(tasks)
          tasks.to_a.map(&:to_s)
        end
      end
    end
  end
end
