require_relative 'base'

module Todo
  module UseCases
    class DoneTest < Base
      def setup
        super
        @task_list = TaskListBuilder.new([{ description: 'hello' }, { description: 'goodbye' }]).build
        @persistence = InMemoryPersistence.new
        @persistence.write_current_day('10-03-1993')
        @persistence.write_todays_tasks(@task_list)
      end

      def test_done_returns_done_todo
       assert_equal('✓ hello', Done.new(persistence: @persistence).perform)
      end

      def test_done_saves_state_of_todos
        Done.new(persistence: @persistence).perform
        expected_task_list = TaskListBuilder.new([{ description: 'hello', done: true}, { description: 'goodbye'}]).build
        assert_equal(expected_task_list, @persistence.read_tasks_for_day('10-03-1993'))
      end

      def test_does_nothing_when_there_are_no_todos
        @persistence.write_current_day('10-04-1993')
        assert_equal('', Done.new(persistence: @persistence).perform)
      end

      def test_done_can_operate_on_a_specific_todo
        task = @task_list.to_a.last
        done_task = Done.new(task, persistence: @persistence).perform
        assert_equal('✓ goodbye', done_task)
      end
    end
  end
end
