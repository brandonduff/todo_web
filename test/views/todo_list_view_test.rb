require 'test_helper'

class TodoListViewTest < Minitest::Test
  def test_list_view
    todos = TodoPresenter.new.present([Todo::Task.new('my todo')])
    view = TodoListView.new(todos)
    assert_includes view.render, 'my todo'
  end
end
