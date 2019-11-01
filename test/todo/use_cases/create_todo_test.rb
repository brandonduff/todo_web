module Todo
  module UseCases
    class CreateTodoTest < Minitest::Test

      def setup
        @persistence = InMemoryPersistence.new
        @persistence.write_current_day('10-03-1993')
      end

      def test_create_todo
        CreateTodo.new('test', persistence: @persistence).perform

        assert_equal("test", @persistence.read_tasks_for_day('10-03-1993').to_s)
      end

      def test_uses_today_by_default
        persistence = InMemoryPersistence.new

        CreateTodo.new('test', persistence: persistence).perform

        assert_equal("test", persistence.read_tasks_for_day(Date.today.strftime("%d-%m-%Y")).to_s)
      end
    end
  end
end
