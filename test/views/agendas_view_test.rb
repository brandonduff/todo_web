require "test_helper"

class AgendaViewsTest < ViewTest
  def test_rendering_multiple_agendas
    # TODO: Refactor:
    # - This setup is too gnarly. At least some factories or something.
    # - I really cheated to make it pass. There's a concept the code doesn't express
    # because I'm using instance_variable_get
    agendas = Agendas.create_null
    first_task_list = TaskList.new
    second_task_list = TaskList.new
    first_task_list << Task.new("my birthday")
    second_task_list << Task.new("dad's birthday")
    first_agenda = Agenda.new(Date.new(1993, 10, 3), first_task_list)
    second_agenda = Agenda.new(Date.new(1993, 11, 3), second_task_list)
    agendas << first_agenda
    agendas << second_agenda

    subject = AgendasView.new(agendas)
    canvas.render(subject)

    assert(canvas.rendered?("my birthday"))
  end
end
