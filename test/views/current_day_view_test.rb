require 'test_helper'
require 'framework/html_component'

class CurrentDayViewTest < Minitest::Test
  def test_rendering_day
    canvas = TestCanvas.build
    date = Date.today
    agenda = Agenda.new(date, Todo::TaskList.new)
    subject = CurrentDayView.new(agenda)
    canvas.render(subject)
    assert canvas.rendered?(paragraph: date)
  end

  def test_changing_date
    canvas = TestCanvas.build
    date = Date.today
    agenda = Agenda.new(date, Todo::TaskList.new)
    subject = CurrentDayView.new(agenda)
    canvas.render(subject)
    canvas.fill_in(:date, date + 1)
    canvas.submit
    assert_equal date + 1, canvas.inputs(:date)
  end

  def test_changing_date_with_agenda
    canvas = TestCanvas.build
    date = Date.today
    agenda = Agenda.new(date, Todo::TaskList.new)
    subject = CurrentDayView.new(agenda)
    canvas.render(subject)
    canvas.fill_in(:date, date + 1)
    canvas.submit
    assert_equal date + 1, canvas.inputs(:date)
    assert_equal date + 1, agenda.current_day
  end
end