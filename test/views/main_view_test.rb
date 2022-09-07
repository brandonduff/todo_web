class MainViewTest < ViewTest
  def test_render
    tasks = TaskList.from_array([Task.new('do the dishes')])
    agenda = Agenda.new(Date.today, tasks)
    subject = MainView.new(agenda)

    canvas.render(subject)
    
    assert canvas.rendered?('do the dishes')
  end
end