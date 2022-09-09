require "test_helper"

class AgendaTest < Minitest::Test
  def test_holds_separate_lists_for_each_day
    wash_the_car = Task.new("wash the car")
    todays_list = TaskList.from_array([wash_the_car])
    subject = Agenda.new(Date.today, todays_list)
    yesterday = Date.today - 1
    do_the_dishes = Task.new("do the dishes")

    subject.current_day = yesterday
    subject.task_list << do_the_dishes

    assert_equal do_the_dishes, subject.task_list.first
    subject.current_day = yesterday + 1
    assert_equal wash_the_car, subject.task_list.first
  end

  def test_new_days_have_empty_list
    subject = Agenda.new(Date.today, TaskList.new)

    subject.current_day = Date.today - 1
    assert_equal TaskList.new, subject.task_list
    subject.task_list << Task.new("do the dishes")
    assert_equal 1, subject.task_list.entries.length
  end
end
