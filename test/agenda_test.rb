require 'test_helper'

class AgendaTest < Minitest::Test
  def test_holds_separate_lists_for_each_day
    todays_list = Todo::TaskList.from_array(['do the dishes'])
    yesterdays_list = Todo::TaskList.from_array(['wash the car'])
    subject = Agenda.new(Date.today, todays_list)
    yesterday = Date.today - 1

    subject.add_list_on_day(yesterdays_list, yesterday)
    subject.current_day = yesterday

    assert_equal yesterdays_list, subject.task_list
  end

  def test_new_days_have_empty_list
    subject = Agenda.new(Date.today, Todo::TaskList.new)

    subject.current_day = Date.today - 1
    assert_equal Todo::TaskList.new, subject.task_list
    subject.task_list << Todo::Task.new('do the dishes')
    assert_equal 1, subject.task_list.entries.length
  end
end