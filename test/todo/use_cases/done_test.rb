module Todo
  module UseCases
    class DoneTest < Minitest::Test
      def setup
        @task_list = TaskListBuilder.new([{ description: 'hello' }, { description: 'goodbye' }]).build
        @log = Hash.new
        @today = '10-03-1993'
        @notepad = Notepad.create_null(log: @log, current_day: @today, tasks: { @today => @task_list })
      end

      def test_done_returns_done_todo
       assert_equal('✓ hello', Done.new(notepad: @notepad).perform)
      end

      def test_done_saves_state_of_todos
        Done.new(notepad: @notepad).perform
        expected_task_list = TaskListBuilder.new([{ description: 'hello', done: true}, { description: 'goodbye'}]).build
        assert_equal(expected_task_list, @log[@today])
      end

      def test_does_nothing_when_there_are_no_todos
        notepad = Notepad.create_null
        assert_equal('', Done.new(notepad: notepad).perform)
      end

      def test_done_can_operate_on_a_specific_todo
        task = @task_list.to_a.last
        done_task = Done.new(task, notepad: @notepad).perform
        assert_equal('✓ goodbye', done_task)
      end
    end
  end
end
