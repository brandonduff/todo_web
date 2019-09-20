require_relative 'base'

module Todo
  module UseCases
    class CreateTodoTest < Base

      def test_create_todo
        CreateTodo.new('test').perform

        assert_equal("test\n", File.read(todo_file_for(@today)))
      end

      def test_does_not_override_existing_todos
        existing_list = TaskList.new
        existing_list.add_task(Task.new('existing', false))
        build_todo_file(todo_file_for(@today))
        save_todo_file(existing_list)

        CreateTodo.new('test').perform

        assert_equal("existing\ntest\n", File.read(todo_file_for(@today)))
      end

      def test_uses_today_by_default
        FileUtils.rm(@current_day_file_name)

        CreateTodo.new('test').perform

        assert_equal("test\n", File.read(todo_file_for(Date.today.strftime("%d-%m-%Y"))))
      end
    end
  end
end
