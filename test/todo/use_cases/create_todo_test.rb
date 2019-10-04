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

      def test_does_not_override_existing_todos
        existing_list = TaskList.new
        existing_list.add_task(Task.new('existing', false))
        @persistence.write_todays_tasks(existing_list)

        CreateTodo.new('test', persistence: @persistence).perform

        expected_list = existing_list.add_task('test')

        assert_equal(expected_list, @persistence.read_tasks_for_day('10-03-1993').to_a)
      end

      def test_uses_today_by_default
        persistence = InMemoryPersistence.new

        CreateTodo.new('test', persistence: persistence).perform

        assert_equal("test", persistence.read_tasks_for_day(Date.today.strftime("%d-%m-%Y")).to_s)
      end
    end
  end
end
