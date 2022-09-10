require "test_helper"

class SaveButtonViewTest < ViewTest
  def test_rendering
    agenda = Agenda.fresh_for_today
    filename = "test_data.store"
    task = Task.new("do the dishes")
    agenda.task_list << task

    canvas.render(SaveButtonView.new(agenda, filename))
    canvas.click(:save)

    assert_equal task, Agendas.create(filename).current.task_list.first

    File.delete("test_data.store") if File.exist?("test_data.store")
  end
end
