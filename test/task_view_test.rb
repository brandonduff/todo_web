require 'test_helper'

class TaskViewTest < Minitest::Test
  def test_rendering_finished_task
    task = Todo::Task.new('do the dishes', true)
    subject = TaskView.new(task)
    canvas = TestCanvas.build

    canvas.render(subject)

    assert canvas.rendered?(list_item: { del: task })
  end
end