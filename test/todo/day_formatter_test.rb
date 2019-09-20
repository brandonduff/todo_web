require 'test_helper'

class DayFormatterTest < Minitest::Test
  def setup
    allow(Date).to receive(:today).and_return(Date.parse("10-03-1993"))
  end

  def test_format_with_date_string_returns_date_string
    assert_equal("10-03-1993", Todo::DayFormatter.format("10-03-1993"))
  end

  def test_format_with_today_returns_current_date
    assert_equal("10-03-1993", Todo::DayFormatter.format("today"))
  end

  def test_format_with_empty_string_returns_current_date
    assert_equal("10-03-1993", Todo::DayFormatter.format(""))
  end

  def test_format_without_year_appends_current_year
    assert_equal("07-11-1993", Todo::DayFormatter.format("7-11"))
  end

  def test_format_with_weekday_string_gives_next_occurrence
    assert_equal(Date.parse("Tuesday").strftime("%d-%m-%Y"), Todo::DayFormatter.format("Tuesday"))
  end
end
