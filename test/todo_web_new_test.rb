require 'test_helper'

class TodoWebNewTest < Minitest::Test
  def setup
    @canvas = TestCanvas.build
  end

  def test_current_day_render
    date = Date.today
    @canvas.render(subject(current_day: date))
    assert @canvas.rendered?(paragraph: date)
  end

  def test_todo_list_render
    @canvas.render(subject(task_list: Todo::TaskList.from_array(['do the dishes'])))
    assert @canvas.rendered?(paragraph: 'do the dishes')
  end

  def subject(task_list: Todo::TaskList.new, current_day: Date.today)
    AgendaView.new(Agenda.new(current_day, task_list))
  end
end