module Todo
  class Persistence
    def self.create_null(log: nil, current_day: nil)
      new(NullIO.new(current_day_path => current_day), log)
    end

    def self.current_day_path
      File.join(ENV['HOME'], '.current_day.txt')
    end

    def initialize(io = FileIO.new, log = nil)
      @io = io
      @log = log
    end

    def write_todays_tasks(tasks)
      ensure_todo_dir_exists
      write(tasks, to: todo_file_for_day(current_day))
    end

    def write_current_day(day)
      write(day, to: current_day_path)
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

    def write(output, to:)
      log[current_day] = output
      @io.write(output, to: to)
    end

    def current_day_path
      self.class.current_day_path
    end

    def todo_path
      File.join(ENV['HOME'], 'todos/')
    end

    def todo_file_for_day(day)
      File.join(todo_path, "#{day}.txt")
    end

    def task_data_for_day(day)
      @io.read(todo_file_for_day(day)) { "" }.split("\n")
    end

    def current_day
      @io.read(current_day_path) { DayFormatter.today }.strip
    end

    def ensure_todo_dir_exists
      @io.ensure_dir(todo_path)
    end

    def log
      @log || {}
    end

    class NullIO
      def initialize(config = {})
        @config = config
      end

      def write(output, to:)

      end

      def ensure_dir(_path)

      end

      def read(file)
        config[file] or yield
      end

      private

      attr_reader :config
    end

    class FileIO
      def ensure_dir(path)
        Dir.mkdir(path) unless Dir.exist?(path)
      end

      def write(output, to:)
        File.open(to, 'a') do |file|
          file.truncate(0)
          file.puts(output)
        end
      end

      def read(file)
        if File.exist?(file)
          File.read(file)
        else
          yield
        end
      end
    end
  end
end
