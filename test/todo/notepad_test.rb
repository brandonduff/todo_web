require 'test_helper'

module Todo
  class NotepadTest < Minitest::Test
    def setup
      ENV["HOME"] = "/tmp"
      @today = "16-09-2020"
      File.write("/tmp/.current_day.txt", @today)
      @notepad = Notepad.new
    end

    def teardown
      ENV["HOME"] = nil
      FileUtils.rm("/tmp/.current_day.txt")
    end

    def test_read_current_day
      assert_equal(@today, @notepad.read_current_day)
    end

    def test_write_current_day
      @notepad.write_current_day("16-10-2020")
      assert_equal("16-10-2020", @notepad.read_current_day)
    end

    def test_write_todays_tasks
      @notepad.write_todays_tasks("do the dishes")
      assert_equal("do the dishes\n", File.read("/tmp/todos/16-09-2020.txt"))
    end

    def test_read_todays_tasks
      @notepad.write_todays_tasks("do the dishes")
      assert_equal("do the dishes", @notepad.read_tasks_for_day(@today).first.to_s)
    end

    class NullabilityTest < NotepadTest
      def test_nullability_when_writing
        FileUtils.rm_r("/tmp/todos") if Dir.exist?("/tmp/todos")

        null_notepad = Notepad.create_null
        null_notepad.write_todays_tasks("do the dishes")

        refute Dir.exist?("/tmp/todos")
        assert_equal(@today, @notepad.read_current_day)
      end

      def test_nullability_when_reading
        null_notepad = Notepad.create_null
        @notepad.write_todays_tasks("do the dishes")
        assert_empty(null_notepad.read_tasks_for_day(@today))
      end

      def test_can_configure_current_day
        null_notepad = Notepad.create_null(current_day: "foo bar")
        assert_equal("foo bar", null_notepad.read_current_day)
      end

      def test_can_configure_tasks_for_day
        null_notepad = Notepad.create_null(tasks: { "1-1-1000" => "plow the field" })
        assert_equal("plow the field", null_notepad.read_tasks_for_day("1-1-1000").first.to_s)
      end

      def test_tracking_written_tasks
        log = {}
        null_notepad = Notepad.create_null(current_day: @today, log: log)

        null_notepad.write_todays_tasks("wash the car")

        assert_equal("wash the car", log[@today])
      end
    end
  end
end
