module Todo
  class MultiTaskListFetcher
    def initialize(notepad, days_ago)
      @notepad = notepad
      @days_ago = days_ago
    end

    def tasks_for_day(day)
      task_list = TaskList.new
      Range.new(Date.parse(day) - @days_ago, Date.parse(day)).each do |date|
        task_list = task_list.concat(TaskListFetcher.new(@notepad).tasks_for_day(date.strftime("%d-%m-%Y")))
      end
      task_list
    end
  end
end
