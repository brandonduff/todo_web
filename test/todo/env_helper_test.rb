require 'test_helper'

module Todo
  class EnvHelperTest < Minitest::Test
    def setup
      ENV['HOME'] = '/tmp/'
      @env_helper = EnvHelper.new
    end

    def test_current_day_path
      assert_equal('/tmp/.current_day.txt', @env_helper.current_day_path)
    end

    def test_todo_path
      assert_equal('/tmp/todos/', @env_helper.todo_path)
    end

    def test_todo_file_for_day
      assert_equal('/tmp/todos/10-10-1993.txt', @env_helper.todo_file_for_day('10-10-1993'))
    end
  end
end
