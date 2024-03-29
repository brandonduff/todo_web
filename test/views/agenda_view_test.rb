require "test_helper"

class AgendaViewTest < ViewTest
  def test_current_day_render
    date = Date.today
    canvas.render(subject(current_day: date))
    assert canvas.rendered?(date)
  end

  def test_todo_list_render
    task = Task.new("do the dishes")
    canvas.render(subject(task_list: TaskList.from_array([task])))
    assert canvas.rendered?("do the dishes")
  end

  def subject(task_list: TaskList.new, current_day: Date.today)
    AgendaView.new(Agenda.new(current_day, task_list))
  end
end
