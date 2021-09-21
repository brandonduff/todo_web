require 'test_helper'
require 'framework/html_component'

class CurrentDayViewTest < ViewTest
  def test_rendering_day
    canvas.render(subject)
    assert canvas.rendered?(paragraph: date)
  end

  def test_changing_date
    canvas.render(subject)
    canvas.fill_in(:date, date + 1)
    canvas.submit
    assert_equal date + 1, canvas.inputs(:date)
  end

  def test_changing_date_with_agenda
    canvas.render(subject)
    canvas.fill_in(:date, date + 1)
    canvas.submit
    assert_equal date + 1, canvas.inputs(:date)
    assert_equal date + 1, agenda.current_day
  end

  def date
    @date ||= Date.today
  end

  def agenda
    @agenda ||= Agenda.new(date, TaskList.new)
  end

  def subject
    @subject ||= CurrentDayView.new(agenda)
  end
end
