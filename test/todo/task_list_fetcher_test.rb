require 'fileutils'
require 'test_helper'

class TaskListFetcherTest < Minitest::Test
  def setup
    @current_day = '03-10-1993'
    @notepad = Todo::Notepad.create_null(current_day: @current_day, tasks: { @current_day => Todo::TaskList.from_array([Todo::Task.new('hello', false)]) })
  end

  def test_task_list_for_current_day
    expected_task_list = Todo::TaskList.new
    expected_task_list.add_task(Todo::Task.new('hello', false))
    assert_equal(fetcher.tasks_for_day(@current_day), expected_task_list)
  end

  def test_for_week_returns_multi_task_list_fetcher_for_week
    assert_equal('hello', fetcher.for_week.tasks_for_day('10-10-1993').first.to_s)
    assert_empty(fetcher.for_week.tasks_for_day('10-11-1993').first.to_s)
  end

  def test_for_month_returns_multi_task_list_fetcher_for_month
    assert_equal('hello', fetcher.for_month.tasks_for_day('3-11-1993').first.to_s)
    assert_empty(fetcher.for_month.tasks_for_day('4-11-1993').first.to_s)
  end

  private

  def fetcher
    Todo::TaskListFetcher.new(@notepad)
  end
end
