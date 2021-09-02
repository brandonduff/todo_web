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
end