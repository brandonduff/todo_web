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

  def test_all_lists
    today = Date.today
    wash_the_car = Task.new("wash the car")
    do_the_dishes = Task.new("do the dishes")
    yesterdays_list = TaskList.from_array([do_the_dishes])
    yesterday = Date.today - 1
    subject = Agenda.new(yesterday, yesterdays_list)

    subject.current_day = today
    subject.task_list << wash_the_car

    first, second = subject.all_lists

    assert_equal today, first[0]
    assert_equal subject.task_list, first[1]
    assert_equal yesterday, second[0]
    assert_equal yesterdays_list, second[1]
  end
end
