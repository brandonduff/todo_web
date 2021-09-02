require 'test_helper'

class TaskViewTest < Minitest::Test
  def test_rendering_finished_task
    task = Todo::Task.new('do the dishes', true)
    canvas.render(TaskView.new(task))

    assert canvas.rendered?(del: task)
  end

  def test_rendering_done
    task = Todo::Task.new('do the dishes')
    canvas.render(TaskView.new(task))

    canvas.click(:finish)

    assert canvas.rendered?(del: task.done)
  end

  def canvas
    @canvas ||= TestCanvas.build
  end
end