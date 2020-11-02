module Todo
  module UseCases
    class ClearTest < Minitest::Test
      def test_clear
        log = Hash.new
        today = '10-03-1993'
        finished_task = Task.new('done', true)
        unfinished_task = Task.new('not done')
        task_list = TaskList.from_array([finished_task, unfinished_task])
        persistence = Persistence.create_null(log: log, current_day: today, tasks: { today => task_list })

        Clear.new(persistence: persistence).perform

        assert_equal([unfinished_task], log[today].to_a)
      end
    end
  end
end
