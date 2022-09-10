require "test_helper"

class AgendasTest < Minitest::Test
  attr_reader :agenda, :agendas

  def setup
    @agenda = Agenda.fresh_for_today
    @agendas = Agendas.new("test_data.store")
  end

  def teardown
    File.delete("test_data.store") if File.exist?("test_data.store")
  end

  def test_adding_agenda
    agendas << agenda

    assert_equal agenda, agendas.entries.first
  end

  def test_agendas_shared_between_instances
    other_subject = Agendas.new("test_data.store")

    agendas << agenda

    assert_equal agenda.task_list, other_subject.entries.first.task_list
  end

  def test_getting_current_returns_an_empty_list_when_nothing_has_been_saved
    assert agendas.current.task_list.empty?
  end

  def test_getting_current_list_returns_an_agenda
    task = Task.new("do the dishes")
    agenda.task_list << task
    agendas << agenda
    assert_equal task, agendas.current.task_list.first
  end
end
