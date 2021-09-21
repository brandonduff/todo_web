require 'test_helper'

class TaskListViewTest < ViewTest
  def test_creating_tasks
    task_list = TaskList.new
    subject = TaskListView.new(task_list)

    canvas.render(subject)
    canvas.fill_in(:new_task, 'do the dishes')
    canvas.submit

    assert canvas.rendered?(list_item: 'do the dishes')
  end

  def test_clearing_finished
    task_list = TaskList.from_array([Task.new('do the dishes', true)])
    subject = TaskListView.new(task_list)

    canvas.render(subject)
    canvas.click(:clear)

    refute canvas.rendered?(list_item: 'do the dishes')
  end
end
