require 'test_helper'
require 'fileutils'

module Todo
  module UseCases
    class Base < Minitest::Test

      def setup
        setup_file_system
      end

      def teardown
        reset_home
      end

      def setup_file_system
        @original_home = ENV['HOME']
        ENV['HOME'] = 'tmp'
        @today = '10-03-1993'
        FileUtils.rm_rf('tmp')
        @current_day_file_name = 'tmp/.current_day.txt'
        Dir.mkdir('tmp') unless Dir.exist?('tmp')
        set_current_day(@today)
        Dir.mkdir('tmp/todos')
      end

      def set_current_day(today)
        current_day = File.open(@current_day_file_name, 'a')
        current_day.puts(today)
        current_day.close
      end

      def reset_home
        ENV['HOME'] = @original_home
      end

      def todo_file_for(day)
        "tmp/todos/#{day}.txt"
      end

      def build_todo_file(todo_file_name = 'tmp/todos/10-03-1993.txt')
        @todo_file = File.open(todo_file_name, 'w+')
      end

      def save_todo_file(task_list)
        Writer.for(task_list).write_to(@todo_file)
        @todo_file.close
      end
    end
  end
end
