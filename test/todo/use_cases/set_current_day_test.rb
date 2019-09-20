require_relative 'base'

module Todo
  module UseCases
    class SetCurrentDayTest < Base
      def test_called_with_nil_day_returns_current_day
        assert_equal(@today, SetCurrentDay.new(new_day: nil).perform)
      end

      def test_called_with_new_day_returns_new_day
        assert_equal(formatted_date('1-1-2000'), SetCurrentDay.new(new_day: '1-1-2000').perform)
      end

      def test_called_with_new_day_writes_new_day
        new_day = '1-2-2002'
        SetCurrentDay.new(new_day: new_day).perform
        assert_equal(formatted_date(new_day), Persistence.new.read_current_day)
      end
      
      def test_setting_new_day_formats_it
        new_day = 'today'
        assert_equal(DayFormatter.new(new_day).today, SetCurrentDay.new(new_day: new_day).perform)
      end

      private

      def formatted_date(date)
        DayFormatter.new(date).format
      end
    end
  end
end
