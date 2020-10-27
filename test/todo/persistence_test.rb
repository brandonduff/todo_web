require 'test_helper'

module Todo
  class PersistenceTest < Minitest::Test
    def setup
      ENV["HOME"] = "/tmp"
      @today = "16-09-2020"
      File.write("/tmp/.current_day.txt", @today)
      @persistence = Persistence.new
    end

    def teardown
      ENV["HOME"] = nil
      FileUtils.rm("/tmp/.current_day.txt")
    end

    def test_read_current_day
      assert_equal(@today, @persistence.read_current_day)
    end

    def test_write_current_day
      @persistence.write_current_day("16-10-2020")
      assert_equal("16-10-2020", @persistence.read_current_day)
    end

    def test_write_todays_tasks
      @persistence.write_todays_tasks("do the dishes")
      assert_equal("do the dishes\n", File.read("/tmp/todos/16-09-2020.txt"))
    end

    def test_read_todays_tasks
      @persistence.write_todays_tasks("do the dishes")
      assert_equal("do the dishes", @persistence.read_tasks_for_day(@today).first.to_s)
    end

    class NullabilityTest < PersistenceTest
      def test_nullability_when_writing
        FileUtils.rm_r("/tmp/todos")

        null_persistence = Persistence.create_null
        null_persistence.write_todays_tasks("do the dishes")

        refute Dir.exist?("/tmp/todos")
        assert_equal(@today, @persistence.read_current_day)
      end

      def test_nullability_when_reading
        null_persistence = Persistence.create_null
        @persistence.write_todays_tasks("do the dishes")
        assert_empty(null_persistence.read_tasks_for_day(@today))
      end

      def test_can_configure_current_day
        null_persistence = Persistence.create_null(current_day: "foo bar")
        assert_equal("foo bar", null_persistence.read_current_day)
      end

      def test_can_configure_tasks_for_day
        null_persistence = Persistence.create_null(current_day: "1-1-1000", tasks: { "1-1-1000" => "plow the field" })
        assert_equal("plow the field", null_persistence.read_tasks_for_day("1-1-1000").first.to_s)
      end

      def test_tracking_written_tasks
        log = {}
        null_persistence = Persistence.create_null(current_day: @today, log: log)

        null_persistence.write_todays_tasks("wash the car")

        assert_equal("wash the car", log[@today])
      end
    end
  end
end
