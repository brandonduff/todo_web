require "test_helper"

class SaveButtonViewTest < ViewTest
  def test_rendering
    agendas = Agendas.create_null
    agenda = Agenda.fresh_for_today
    task = Task.new("do the dishes")
    agenda.task_list << task

    canvas.render(SaveButtonView.new(agenda, agendas))
    canvas.click(:save)

    assert_equal task, agendas.current.task_list.first
  end
end
