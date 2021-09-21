require 'test_helper'

class TaskViewTest < ViewTest
  def test_rendering_finished_task
    task = Todo::Task.new('do the dishes', true)
    canvas.render(TaskView.new(task))

    assert canvas.rendered?(del: 'do the dishes')
  end

  def test_rendering_done
    task = Todo::Task.new('do the dishes')
    canvas.render(TaskView.new(task))

    canvas.click(:finish)

    assert canvas.rendered?(del: 'do the dishes')
  end

  def test_moving
    task = Todo::Task.new('do the dishes')
    list = Todo::TaskList.from_array([Todo::Task.new('wash the car'), task])
    canvas.render(TaskView.new(task))

    canvas.click(:move_up)

    assert_equal task, list.first

    canvas.click(:move_down)

    refute_equal task, list.first
  end
end
