require 'test_helper'

class TestTodoPresenter < Minitest::Test
  def setup
    @todo = Todo::Task.new('foo', false)
    @todo_two = Todo::Task.new('bar', false)
  end

  def todos
    [@todo, @todo_two]
  end

  def presented_todos
    TodoPresenter.new.present(todos)
  end

  def test_presents_undone_todos_as_strings
    assert_equal presented_todos.map(&:description), %w(foo bar)
  end

  def test_it_strips_checkmarks_from_done_todos
    @todo = Todo::Task.new('done', true)
    assert_includes presented_todos.map(&:description), '<del>done</del>'
  end

  def test_done_action
    todo = Todo::Task.new('finish me')
    assert_equal "/done/#{URI::escape(todo.description)}", TodoPresenter.new.present([todo]).first.done_action
  end
end
