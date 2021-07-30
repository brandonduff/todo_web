require 'test_helper'

class TaskListViewTest < Minitest::Test
  def test_creating_tasks
    task_list = Todo::TaskList.new
    canvas = TestCanvas.build
    subject = TaskListView.new(task_list)

    canvas.render(subject)
    canvas.fill_in(:new_task, 'do the dishes', subject)
    canvas.submit(subject)

    canvas.fill_in(:new_task, 'wash the car', subject)
    canvas.submit(subject)

    assert canvas.rendered?(list_item: Todo::Task.new('do the dishes'))
    assert canvas.rendered?(list_item: Todo::Task.new('wash the car'))
  end
end