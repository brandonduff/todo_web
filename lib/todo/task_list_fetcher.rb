module Todo
  class TaskListFetcher
    def initialize(notepad)
      @notepad = notepad
      @days_ago = 0
    end

    def tasks_for_day(day)
      TaskList.new.tap do |task_list|
        date_range(day).each do |date|
          task_list.concat(@notepad.read_tasks_for_day(date))
        end
      end
    end

    def for_week
      @days_ago = 7
      self
    end

    def for_month
      @days_ago = 31
      self
    end

    private

    def date_range(day)
      date = Date.parse(day)
      (date - @days_ago)..date
    end
  end
end
