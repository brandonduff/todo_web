require 'test_helper'

class TaskListViewTest < Minitest::Test
  def test_creating_tasks
    task_list = Todo::TaskList.new
    canvas = TestCanvas.build
    subject = TaskListView.new(task_list)

    canvas.render(subject)
    canvas.fill_in(:new_task, 'do the dishes')
    canvas.submit

    assert canvas.rendered?(list_item: 'do the dishes')
  end
end