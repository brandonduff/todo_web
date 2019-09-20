require_relative 'base'

module Todo
  module UseCases
    class UndoTest < Base
      def setup
        super
        build_todo_file(todo_file_for('10-03-1993'))
        task_list = TaskListBuilder.new([{ description: 'no longer done', done: true }, { description: 'not done' }]).build
        save_todo_file(task_list)
      end

      def test_undo_writes_task_list
        Undo.new.perform
        assert_equal("no longer done\nnot done\n", File.read(todo_file_for('10-03-1993')))
      end

      def test_undo_presents_undone_todo
        assert_equal("no longer done", Undo.new.perform)
      end

      def test_with_empty_list
        set_current_day('10-04-1993')
        assert_equal('', Undo.new.perform)
      end
    end
  end
end
