module Todo
  class InMemoryPersistence
    def write_todays_tasks(new_tasks)
      tasks[@current_day] = new_tasks
    end

    def write_current_day(day)
      @current_day = day
    end

    def read_tasks_for_day(day)
      tasks[day]
    end

    def read_current_day
      @current_day
    end

    private

    def tasks
      @tasks ||= Hash.new(TaskList.new)
    end
  end
end