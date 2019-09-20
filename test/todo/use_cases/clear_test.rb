require_relative 'base'

module Todo
  module UseCases
    class ClearTest < Base
      def setup
        super
        build_todo_file(todo_file_for('10-03-1993'))
        task_list = TaskListBuilder.new([{ description: 'done', done: true }, { description: 'not done' }]).build
        save_todo_file(task_list)
      end

      def test_clear
        Clear.new.perform
        assert_equal("not done\n", File.read(todo_file_for('10-03-1993')))
      end
    end
  end
end
