module Todo
  class Reader
    def initialize(env_helper)
      @env_helper = env_helper
    end

    def task_data_for_day(day)
      File.exist?(@env_helper.todo_file_for_day(day)) ? File.read(@env_helper.todo_file_for_day(day)).split("\n") : []
    end

    def current_day
      File.exist?(@env_helper.current_day_path) ? File.read(@env_helper.current_day_path).strip : DayFormatter.today
    end
  end
end
