require_relative 'base'

module Todo
  module UseCases
    class ListTodosTest < Minitest::Test

      def setup
        @today = '10-03-1993'
        @persistence = InMemoryPersistence.new
        @persistence.write_current_day(@today)
      end

      def test_list_with_no_current_todos_returns_empty_list
        todos = ListTodos.new(persistence: @persistence).perform

        assert_equal([], todos)
      end

      def test_list_returns_todos_as_array
        task_list = TaskListBuilder.new([{ description: 'hello' }, { description: 'goodbye' }]).build
        @persistence.write_todays_tasks(task_list)

        todos = ListTodos.new(persistence: @persistence).perform

        assert_equal(%w(hello goodbye), todos)
      end

      def test_all_options_returns_unfinished_tasks
        task_list = TaskListBuilder.new([{ description: 'hello' }]).build
        done_todo = Task.new('done', true)
        task_list.add_task(done_todo)
        @persistence.write_todays_tasks(task_list)

        todos = ListTodos.new(all: true, persistence: @persistence).perform

        assert_equal([task_list.to_a[0].formatted_description, done_todo.formatted_description], todos)
      end

      def test_week_option
        second_task_list = TaskListBuilder.new([description: 'world']).build
        @persistence.write_todays_tasks(second_task_list)
        yesterday = '09-03-1993'
        @persistence.write_current_day(yesterday)
        first_task_list = TaskListBuilder.new([description: 'hello']).build
        @persistence.write_todays_tasks(first_task_list)
        @persistence.write_current_day(@today)

        todos = ListTodos.new(week: true, persistence: @persistence).perform

        assert_equal([first_task_list.to_a.first.formatted_description, second_task_list.to_a.first.formatted_description], todos)
      end

      def test_month_option
        last_week = '01-03-1993'
        second_task_list = TaskListBuilder.new([description: 'world']).build
        @persistence.write_todays_tasks(second_task_list)
        @persistence.write_current_day(last_week)
        first_task_list = TaskListBuilder.new([description: 'hello']).build
        @persistence.write_todays_tasks(first_task_list)
        @persistence.write_current_day(@today)

        todos = ListTodos.new(month: true, persistence: @persistence).perform

        assert_equal([first_task_list.to_a.first.formatted_description, second_task_list.to_a.first.formatted_description], todos)
      end

      def test_accepts_presenter
        task_list = TaskListBuilder.new([{ description: 'hello', done: false }, { description: 'goodbye', done: false }]).build
        @persistence.write_todays_tasks(task_list)
        console_presenter = double
        allow(console_presenter).to receive(:present).with(task_list.to_a).and_return('presented tasks')

        todos = ListTodos.new(presenter: console_presenter, persistence: @persistence).perform

        assert_equal('presented tasks', todos)
      end
    end
  end
end
