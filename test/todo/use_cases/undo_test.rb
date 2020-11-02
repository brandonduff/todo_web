module Todo
  module UseCases
    class UndoTest < Minitest::Test
      def setup
        @log = Hash.new
        @today = '10-03-1993'
        task_list = TaskListBuilder.new([{ description: 'no longer done', done: true }, { description: 'not done' }]).build
        @null_persistence = Persistence.create_null(log: @log, current_day: @today, tasks: { @today => task_list })
      end

      def test_undo_writes_task_list
        expected_tasks = TaskListBuilder.new([{ description: 'no longer done' }, { description: 'not done' }]).build
        Undo.new(persistence: @null_persistence).perform
        assert_equal(expected_tasks, @log[@today])
      end

      def test_undo_presents_undone_todo
        assert_equal("no longer done", Undo.new(persistence: @null_persistence).perform)
      end

      def test_with_empty_list
        persistence = Persistence.create_null(log: @log, current_day: @today)
        assert_equal('', Undo.new(persistence: persistence).perform)
      end
    end
  end
end
