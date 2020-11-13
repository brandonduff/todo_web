module Todo
  module UseCases
    class UndoTest < Minitest::Test
      def setup
        @log = Hash.new
        @today = '10-03-1993'
        task_list = TaskListBuilder.new([{ description: 'no longer done', done: true }, { description: 'not done' }]).build
        @null_notepad = Notepad.create_null(log: @log, current_day: @today, tasks: { @today => task_list })
      end

      def test_undo_writes_task_list
        expected_tasks = TaskListBuilder.new([{ description: 'no longer done' }, { description: 'not done' }]).build
        Undo.new(notepad: @null_notepad).perform
        assert_equal(expected_tasks, @log[@today])
      end

      def test_undo_presents_undone_todo
        assert_equal("no longer done", Undo.new(notepad: @null_notepad).perform)
      end

      def test_with_empty_list
        notepad = Notepad.create_null(log: @log, current_day: @today)
        assert_equal('', Undo.new(notepad: notepad).perform)
      end
    end
  end
end
