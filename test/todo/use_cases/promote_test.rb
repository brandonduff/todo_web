module Todo
  module UseCases
    class PromoteTest < MiniTest::Test
      def test_promoting_a_todo
        log = Hash.new
        today = '10-03-1993'
        task_list = TaskList.from_array([Task.new('first task'), Task.new('second task')])
        persistence = Persistence.create_null(log: log, current_day: today, tasks: { today => task_list })

        Promote.new(persistence: persistence).perform('second task')

        assert_equal 'second task', log[today].first.to_s
      end
    end
  end
end
