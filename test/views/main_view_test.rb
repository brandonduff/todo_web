class MainViewTest < ViewTest
  def test_render
    tasks = TaskList.from_array([Task.new("do the dishes")])
    yesterday_tasks = TaskList.from_array([Task.new("wash the car")])
    agenda = Agenda.new(Date.today, tasks)
    yesterday_agenda = Agenda.new(Date.today - 1, yesterday_tasks)
    agendas = Agendas.create_null
    agendas << agenda
    agendas << yesterday_agenda
    subject = MainView.new(agendas)

    canvas.render(subject)

    assert canvas.rendered?("do the dishes")
    assert canvas.rendered?(:save)
    assert canvas.rendered?("wash the car")
  end
end
