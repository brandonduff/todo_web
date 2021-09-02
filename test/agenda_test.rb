require 'test_helper'

class AgendaTest < Minitest::Test
  def test_initialization
    Agenda.new(Date.today, Todo::TaskList.new)
  end
end