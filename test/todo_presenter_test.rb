require 'minitest/autorun'
require 'todo_presenter'
require 'todo/task'

class TestTodoPresenter < Minitest::Test
  def setup
    @todo = Todo::Task.new('foo', false)
    @todo_two = Todo::Task.new('bar', false)
  end

  def todos
    [@todo, @todo_two]
  end

  def presented_todos
    TodoWeb::TodoPresenter.new.present(todos)
  end

  def test_presents_undone_todos_as_strings
    assert_equal presented_todos, %w(foo bar)
  end

  def test_it_strips_checkmarks_from_done_todos
    @todo = Todo::Task.new('done', true)
    assert_includes presented_todos, '<del>done</del>'
  end
end
