require "test_helper"

class AgendasTest < Minitest::Test
  attr_reader :agenda, :agendas

  def setup
    @agenda = Agenda.fresh_for_today
    @agenda.task_list << Task.new("do the dishes")
    @agendas = Agendas.create("test_data.store")
  end

  def teardown
    File.delete("test_data.store") if File.exist?("test_data.store")
  end

  def test_adding_agenda
    agendas << agenda

    assert_equal agenda, agendas.entries.first
  end

  def test_agendas_shared_between_instances
    other_subject = Agendas.create("test_data.store")

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

  def test_nullability
    null_agendas = Agendas.create_null
    null_agendas << agenda
    assert_nil agendas.entries.first
  end

  def test_updating_agenda
    null_agendas = Agendas.create_null
    null_agendas << agenda

    new_task = Task.new("wash the car")
    agenda.task_list << new_task
    null_agendas << agenda

    assert_equal 1, null_agendas.entries.count
    assert_equal new_task, null_agendas.current.task_list.last
  end
end
