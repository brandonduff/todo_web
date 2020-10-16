module Todo
  class Persistence
    def initialize
      @writer = Writer.new
    end

    def write_todays_tasks(tasks)
      ensure_todo_dir_exists
      @writer.write(tasks, to: todo_file_for_day(current_day))
    end

    def write_current_day(day)
      @writer.write(day, to: current_day_path)
    end

    def read_tasks_for_day(day)
      task_data = task_data_for_day(day)
      TaskList.new.tap do |task_list|
        task_data.each do |task|
          task_list.add_task(TaskBuilder.new(task).build)
        end
      end
    end

    def read_current_day
      current_day
    end

    private
    
    def current_day_path
      File.join(ENV['HOME'], '.current_day.txt')
    end

    def todo_path
      File.join(ENV['HOME'], 'todos/')
    end

    def todo_file_for_day(day)
      File.join(todo_path, "#{day}.txt")
    end
    
    def task_data_for_day(day)
      File.exist?(todo_file_for_day(day)) ? File.read(todo_file_for_day(day)).split("\n") : []
    end

    def current_day
      File.exist?(current_day_path) ? File.read(current_day_path).strip : DayFormatter.today
    end

    def ensure_todo_dir_exists
      Dir.mkdir(todo_path) unless Dir.exist?(todo_path)
    end
  end
end
