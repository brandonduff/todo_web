module Todo
  module UseCases
    class ClearTest < Minitest::Test
      def setup
        task_list = TaskListBuilder.new([{ description: 'done', done: true }, { description: 'not done', done: false }]).build
        @persistence = InMemoryPersistence.new
        @persistence.write_current_day('10-03-1993')
        @persistence.write_todays_tasks(task_list)
      end

      def test_clear
        Clear.new(persistence: @persistence).perform
        assert_equal([Task.new('not done', false)], @persistence.read_tasks_for_day('10-03-1993').to_a)
      end
    end
  end
end
