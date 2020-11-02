module Todo
  module UseCases
    class CreateTodoTest < Minitest::Test
      def setup
        @today = '10-03-1993'
        @log = Hash.new
        @persistence = Persistence.create_null(log: @log, current_day: @today)
      end

      def test_create_todo
        CreateTodo.new('test', persistence: @persistence).perform
        assert_equal("test", @log[@today].to_s)
      end

      def test_uses_today_by_default
        persistence = Persistence.create_null(log: @log)
        CreateTodo.new('test', persistence: persistence).perform
        assert_equal("test", @log[Date.today.strftime("%d-%m-%Y")].to_s)
      end
    end
  end
end
