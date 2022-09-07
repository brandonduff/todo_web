require "test_helper"

class AgendasTest < Minitest::Test
  attr_reader :agenda, :agendas

  def setup
    @agenda = Agenda.fresh_for_today
    @agendas = Agendas.new
  end

  def teardown
    Agendas.clear
  end

  def test_adding_agenda
    agendas << agenda

    assert_equal agenda, agendas.entries.first
  end  

  def test_agendas_shared_between_instances
    other_subject = Agendas.new

    agendas << agenda    

    assert_equal agenda, other_subject.entries.first
  end
end