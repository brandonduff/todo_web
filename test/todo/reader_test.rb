require 'test_helper'
require 'tempfile'

module Todo
  class ReaderTest < Minitest::Test

    def setup
      @env_helper = double
    end

    def test_get_current_day_when_file_exists
      current_day = '1-1-2000'
      todo_path = 'foo'
      current_day_file = Tempfile.new(todo_path)
      current_day_file.puts(current_day)
      current_day_file.close
      allow(@env_helper).to receive(:current_day_path).and_return(current_day_file.path)
      reader = Reader.new(@env_helper)

      assert_equal(current_day, reader.current_day)
    end


    def test_get_current_day_when_file_doesnt_exist_returns_current_day
      allow(@env_helper).to receive(:current_day_path).and_return('non_existent')
      reader = Reader.new(@env_helper)

      assert_equal(Date.today.strftime("%d-%m-%Y"), reader.current_day)
    end

    def test_task_data_for_day_when_file_exists
      current_day = '1-1-2000'
      todo_path = 'foo'
      todo_file = Tempfile.new(todo_path)
      todo_file.puts("hello foo\ngoodbye")
      todo_file.close
      allow(@env_helper).to receive(:todo_file_for_day).with(current_day).and_return(todo_file.path)

      reader = Reader.new(@env_helper)

      assert_equal(['hello foo', 'goodbye'], reader.task_data_for_day(current_day))
    end

    def test_task_data_for_day_when_file_does_not_exist
      current_day = '1-1-2000'
      allow(@env_helper).to receive(:todo_file_for_day).with(current_day).and_return('non-existent')

      reader = Reader.new(@env_helper)

      assert_equal([], reader.task_data_for_day(current_day))
    end
  end
end
