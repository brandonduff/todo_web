require 'fileutils'
require 'test_helper'

class TaskListFetcherTest < Minitest::Test
  def setup
    @current_day = Date.parse('10-03-1993')
    @multi_task_fetcher_double = Object.new
    @persistence = double
    allow(@persistence).to receive(:read_tasks_for_day).with(@current_day).and_return(Todo::TaskList.from_array([Todo::Task.new('hello', false)]))
  end

  def test_task_list_for_current_day
    fetcher = Todo::TaskListFetcher.new(@persistence)
    expected_task_list = Todo::TaskList.new
    expected_task_list.add_task(Todo::Task.new('hello', false))
    assert_equal(fetcher.tasks_for_day(@current_day), expected_task_list)
  end

  def test_for_week_returns_multi_task_list_fetcher_for_week
    allow(Todo::MultiTaskListFetcher).to receive(:new).with(@persistence, 7).and_return(@multi_task_fetcher_double)

    assert_equal(@multi_task_fetcher_double, Todo::TaskListFetcher.new(@persistence).for_week)
  end

  def test_for_month_returns_multi_task_list_fetcher_for_month
    allow(Todo::MultiTaskListFetcher).to receive(:new).with(@persistence, 31).and_return(@multi_task_fetcher_double)

    assert_equal(@multi_task_fetcher_double, Todo::TaskListFetcher.new(@persistence).for_month)
  end
end
