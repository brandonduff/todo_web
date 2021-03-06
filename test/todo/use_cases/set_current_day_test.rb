module Todo
  module UseCases
    class SetCurrentDayTest < Minitest::Test
      def setup
        @today = '10-03-1993'
        @log = Hash.new
        @null_notepad = Notepad.create_null(current_day: @today, log: @log)
      end

      def test_called_with_nil_day_returns_current_day
        assert_equal(@today, SetCurrentDay.new(new_day: nil, notepad: @null_notepad).perform)
      end

      def test_called_with_new_day_returns_current_day
        result = SetCurrentDay.new(new_day: '1-1-2000', notepad: @null_notepad).perform
        assert_equal(@today, result)
        assert_equal('01-01-2000', @log[@today])
      end

      def test_setting_new_day_formats_it
        new_day = 'today'
        SetCurrentDay.new(new_day: new_day, notepad: @null_notepad).perform
        assert_equal(DayFormatter.today, @log[@today])
      end
    end
  end
end
