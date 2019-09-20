module Todo
  class TaskListFetcher
    def initialize(persistence)
      @persistence = persistence
    end

    def tasks_for_day(day)
      @persistence.read_tasks_for_day(day)
    end

    def for_week
      multi_list_fetcher_for_days_ago(7)
    end

    def for_month
      multi_list_fetcher_for_days_ago(31)
    end

    private

    def multi_list_fetcher_for_days_ago(days_ago)
      MultiTaskListFetcher.new(@persistence, days_ago)
    end
  end
end
