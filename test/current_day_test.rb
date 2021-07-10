require 'test_helper'
require 'framework/html_component'

class TestCanvas < HtmlCanvas
  def self.build
    new(continuation_dictionary: ContinuationDictionary.new)
  end

  def paragraph(*args, &block)
    rendered[:paragraph] << args.first
  end

  def rendered?(args)
    rendered[:paragraph].include?(args[:paragraph])
  end

  def date_input(attribute)
    rendered[:input] << attribute
  end

  def fill_in(input, value)
    rendered[:input][input].value = value
  end

  def rendered
    @rendered ||= Hash.new { |hash, key| hash[key] = [] }
  end
end

class CurrentDayTest < Minitest::Test
  def test_rendering_day
    canvas = TestCanvas.build
    date = Date.today
    subject = CurrentDay.new(date)
    canvas.render(subject)
    assert canvas.rendered?(paragraph: date)
  end

  def test_changing_date
    canvas = TestCanvas.build
    date = Date.today
    subject = CurrentDay.new(date)
    subject.date = date + 1
    canvas.render(subject)
    canvas.fill_in(:date, date + 1)
    canvas.submit
    assert_equal date + 1, canvas.inputs[:date].value
  end
end