module Todo
  class EnvHelper
    def current_day_path
      File.join(ENV['HOME'], '.current_day.txt')
    end

    def todo_path
      File.join(ENV['HOME'], 'todos/')
    end

    def todo_file_for_day(day)
      File.join(todo_path, "#{day}.txt")
    end
  end
end
