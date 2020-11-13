require 'test_helper'

class MultiTaskListFetcherTest < Minitest::Test
  def test_task_data_for_one_day_range
    day = '10-03-1993'
    notepad = Todo::Notepad.create_null(current_day: '10-03-1993', tasks: { day => 'data' })

    assert_equal(Todo::TaskList.from_array(['data']).to_s, Todo::MultiTaskListFetcher.new(notepad, 0).tasks_for_day(day).to_s)
  end

  def test_task_data_for_range
    first_day = '10-10-1993'
    second_day = '11-10-1993'
    third_day = '12-10-1993'
    notepad = Todo::Notepad.create_null(current_day: '10-10-1993', tasks: { first_day => 'first', second_day => 'second', third_day => 'third' })
    assert_equal(Todo::TaskList.from_array(%w(first second third)).to_s, Todo::MultiTaskListFetcher.new(notepad, 2).tasks_for_day(third_day).to_s)
  end
end
