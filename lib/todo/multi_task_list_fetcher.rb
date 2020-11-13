module Todo
  class MultiTaskListFetcher
    def initialize(notepad, days_ago)
      @notepad = notepad
      @days_ago = days_ago
    end

    def tasks_for_day(day)
      TaskList.new.tap do |task_list|
        (Date.parse(day) - @days_ago..Date.parse(day)).each do |date|
          task_list.concat(TaskListFetcher.new(@notepad).tasks_for_day(date.strftime("%d-%m-%Y")))
        end
      end
    end
  end
end
