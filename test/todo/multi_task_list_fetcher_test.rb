require 'test_helper'

class MultiTaskListFetcherTest < Minitest::Test

  def setup
    @reader = Object.new
  end

  def test_task_data_for_one_day_range
    first_day = '10-03-1993'
    second_day = first_day
    fetcher = instance_double("TaskListFetcher")

    allow(Todo::TaskListFetcher).to receive(:new).with(@reader).and_return(fetcher)
    allow(fetcher).to receive(:tasks_for_day).with(second_day).and_return(['data'])

    assert_equal(Todo::TaskList.from_array(['data']), Todo::MultiTaskListFetcher.new(@reader, 0).tasks_for_day(second_day))
  end

  def test_task_data_for_range
    first_day = '10-03-1993'
    second_day = '11-03-1993'
    third_day = '12-03-1993'
    fetcher = instance_double("TaskListFetcher")

    allow(Todo::TaskListFetcher).to receive(:new).with(@reader).and_return(fetcher)
    allow(fetcher).to receive(:tasks_for_day).with(first_day).and_return(['first'])
    allow(fetcher).to receive(:tasks_for_day).with(second_day).and_return(['second'])
    allow(fetcher).to receive(:tasks_for_day).with(third_day).and_return(['third'])


    assert_equal(Todo::TaskList.from_array(%w(first second third)), Todo::MultiTaskListFetcher.new(@reader, 2).tasks_for_day(third_day))
  end
end
