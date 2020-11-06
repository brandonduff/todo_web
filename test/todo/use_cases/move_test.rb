module Todo
  module UseCases
    class MoveTest < MiniTest::Test
      def setup
        @log = Hash.new
        @today = '10-03-1993'
        @task_list = TaskList.from_array([Task.new('first task'), Task.new('second task')])
        @persistence = Persistence.create_null(log: @log, current_day: @today, tasks: { @today => @task_list })
      end

      def test_promoting_a_todo
        Move.new(persistence: @persistence).perform('second task', :up)

        assert_equal 'second task', @log[@today].first.to_s
      end

      def test_demoting_a_todo
        Move.new(persistence: @persistence).perform('first task', :down)

        assert_equal 'second task', @log[@today].first.to_s
      end
    end
  end
end
