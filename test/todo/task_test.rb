require 'test_helper'

module Todo
  class TaskTest < Minitest::Test
    def setup
      @task_item = Todo::Task.new('do this and that')
    end

    def test_initialized_as_done
      task_item = Todo::Task.new('do this and that', true)
      assert(task_item.done?)
    end

    def test_description
      assert_equal('do this and that', @task_item.formatted_description)
    end

    def test_done
      @task_item.done
      assert_equal('✓ do this and that', @task_item.formatted_description)
    end

    def test_done?
      assert(!@task_item.done?)
      @task_item.done
      assert(@task_item.done?)
    end

    def test_in_progress?
      assert(@task_item.in_progress?)
      @task_item.done
      assert(!@task_item.in_progress?)
    end

    def test_undo_with_one_done_task_undoes_it
      @task_item.done
      @task_item.undo
      assert_equal('do this and that', @task_item.formatted_description)
    end

    def test_equality_is_true_when_description_and_doneness_are_eqaul
      other_task = Todo::Task.new(@task_item.formatted_description)
      assert_equal(other_task, @task_item)

      other_task = Todo::Task.new(@task_item.formatted_description, true)
      assert(other_task != @task_item)

      other_task = Todo::Task.new('different description')
      assert(other_task != @task_item)
    end

    def test_can_move_up_and_down
      last_task = Todo::Task.new('wash the car')
      list = Todo::TaskList.from_array([Todo::Task.new('do the dishes'), last_task])
      last_task.move_up
      assert_equal last_task, list.first
      last_task.move_down
      refute_equal last_task, list.first
    end
  end
end
