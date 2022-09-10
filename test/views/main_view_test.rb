class MainViewTest < ViewTest
  def test_render
    tasks = TaskList.from_array([Task.new("do the dishes")])
    agenda = Agenda.new(Date.today, tasks)
    agendas = Agendas.create_null
    agendas << agenda
    subject = MainView.new(agendas)

    canvas.render(subject)

    assert canvas.rendered?("do the dishes")
    assert canvas.rendered?(:save)
  end
end
