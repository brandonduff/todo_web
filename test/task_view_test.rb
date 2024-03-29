require "test_helper"

class TaskViewTest < ViewTest
  def test_rendering_finished_task
    task = Task.new("do the dishes", true)
    canvas.render(TaskView.new(task))

    assert canvas.rendered?(del: "do the dishes")
  end

  def test_rendering_done
    task = Task.new("do the dishes")
    canvas.render(TaskView.new(task))

    canvas.click(:finish)

    assert canvas.rendered?(del: "do the dishes")
  end

  def test_moving
    task = Task.new("do the dishes")
    list = TaskList.from_array([Task.new("wash the car"), task])
    canvas.render(TaskView.new(task))

    canvas.click("^")

    assert_equal task, list.first

    canvas.click("v")

    refute_equal task, list.first
  end

  def test_undo
    task = Task.new("wash the car")
    task.done
    canvas.render(TaskView.new(task))

    canvas.click(:undo)

    refute task.done?
  end

  def test_finish_undo_toggle
    task = Task.new("wash the car")
    canvas.render(TaskView.new(task))
    assert canvas.rendered?(:finish)
    refute canvas.rendered?(:undo)

    canvas.click(:finish)

    assert canvas.rendered?(:undo)
    refute canvas.rendered?(:finish)
  end
end
