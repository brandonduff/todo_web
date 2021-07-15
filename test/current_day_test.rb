require 'test_helper'
require 'framework/html_component'

class CurrentDayTest < Minitest::Test
  def test_rendering_day
    canvas = TestCanvas.build
    date = Date.today
    subject = CurrentDayView.new(date)
    canvas.render(subject)
    assert canvas.rendered?(paragraph: date)
  end

  def test_changing_date
    canvas = TestCanvas.build
    date = Date.today
    subject = CurrentDayView.new(date)
    subject.date = date + 1
    canvas.render(subject)
    canvas.fill_in(:date, date + 1)
    canvas.submit
    assert_equal date + 1, canvas.inputs(:date)
  end
end