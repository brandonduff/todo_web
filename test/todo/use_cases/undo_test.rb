module Todo
  module UseCases
    class UndoTest < Minitest::Test
      def setup
        task_list = TaskListBuilder.new([{ description: 'no longer done', done: true }, { description: 'not done' }]).build
        @persistence = InMemoryPersistence.new
        @today = '10-03-1993'
        @persistence.write_current_day(@today)
        @persistence.write_todays_tasks(task_list)
      end

      def test_undo_writes_task_list
        expected_tasks = TaskListBuilder.new([{description: 'no longer done'}, { description: 'not done' }]).build
        Undo.new(persistence: @persistence).perform
        assert_equal(expected_tasks, @persistence.read_tasks_for_day(@today))
      end

      def test_undo_presents_undone_todo
        assert_equal("no longer done", Undo.new(persistence: @persistence).perform)
      end

      def test_with_empty_list
        @persistence.write_current_day('10-04-1993')
        assert_equal('', Undo.new(persistence: @persistence).perform)
      end
    end
  end
end
