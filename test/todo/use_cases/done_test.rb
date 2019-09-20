require_relative 'base'

module Todo
  module UseCases
    class DoneTest < Base
      def setup
        super
        build_todo_file(todo_file_for('10-03-1993'))
        task_list = TaskListBuilder.new([{ description: 'hello' }, { description: 'goodbye' }]).build
        save_todo_file(task_list)
      end

      def test_done_returns_done_todo
       assert_equal('✓ hello', Done.new.perform)
      end

      def test_done_saves_state_of_todos
        Done.new.perform
        assert_equal("✓ hello\ngoodbye\n", File.read(todo_file_for('10-03-1993')))
      end

      def test_does_nothing_when_there_are_no_todos
        set_current_day('10-04-1993')
        assert_equal('', Done.new.perform)
      end
    end
  end
end
