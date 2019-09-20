require 'test_helper'

class TaskListTest < Minitest::Test

  def setup
    @task_list = Todo::TaskList.new(StringIO.new)
  end

  def test_adding_tasks
    task = Todo::Task.new('hi')
    @task_list.add_task(task)

    assert_equal(@task_list.to_s, 'hi')
  end

  def test_to_s_with_no_tasks
    assert(@task_list.to_s.empty?)
  end

  def test_to_s_with_one_tasks
    @task_list.add_task(Todo::Task.new('hi'))

    assert_equal(@task_list.to_s, 'hi')
  end

  def test_to_s_with_multiple_tasks
    @task_list.add_task(Todo::Task.new('hi'))
    @task_list.add_task(Todo::Task.new('guy'))

    assert_equal(@task_list.to_s, "hi\nguy")
  end

  def test_initialize_from_existing_buffer
    initial_buffer = StringIO.new
    initial_buffer << "hi\ntry\nguy\n"
    builder = instance_double("TaskBuilder")
    expect(Todo::TaskBuilder).to receive(:new).with('hi').and_return(builder)
    expect(Todo::TaskBuilder).to receive(:new).with('try').and_return(builder)
    expect(Todo::TaskBuilder).to receive(:new).with('guy').and_return(builder)
    expect(builder).to receive(:build).exactly(3).times

    Todo::TaskList.new(initial_buffer)
  end

  def test_done_on_empty_list_does_nothing
    @task_list.done
    assert_equal(@task_list.to_s, '')
  end

  def test_done_on_one_task_marks_todo_as_done
    @task_list.add_task(Todo::Task.new('hi'))
    @task_list.done
    assert_equal('✓ hi', @task_list.to_s)
  end

  def test_done_on_list_with_done_tasks_marks_first_unfinished_task_as_done
    @task_list.add_task(Todo::Task.new('i am already done'))
    @task_list.done
    @task_list.add_task(Todo::Task.new('i am now done'))
    @task_list.done
    assert_equal("✓ i am already done\n✓ i am now done", @task_list.to_s)
  end

  def test_clear_on_empty_list_does_nothing
    @task_list.clear
    assert_equal(@task_list.to_s, '')
  end

  def test_clear_with_no_done_tasks_does_nothing
    @task_list.add_task(Todo::Task.new('hi'))
    @task_list.clear
    assert_equal('hi', @task_list.to_s)
  end

  def test_clear_with_one_done_task_removes_it
    @task_list.add_task(Todo::Task.new('hi', true))
    @task_list.add_task(Todo::Task.new('not done'))
    @task_list.clear
    assert_equal('not done', @task_list.to_s)
  end

  def test_clear_with_multiple_done_tasks_removes_them
    @task_list.add_task(Todo::Task.new('hi', true))
    @task_list.add_task(Todo::Task.new('done', true))
    @task_list.add_task(Todo::Task.new('not done'))
    @task_list.clear
    assert_equal('not done', @task_list.to_s)
  end

  def test_in_progress_tasks_returns_unfinished_tasks
    @task_list.add_task(Todo::Task.new('done'))
    @task_list.done
    @task_list.add_task(Todo::Task.new('not done'))
    assert_equal('not done', @task_list.unfinished_tasks.to_s)
  end

  def test_undo_with_one_task_undoes_it
    task = Todo::Task.new('done')
    done_task_list = Todo::TaskList.new
    done_task_list.add_task(task)
    @task_list.add_task(task)
    @task_list.done

    @task_list.undo

    assert_equal(done_task_list, @task_list.unfinished_tasks)
  end

  def test_undo_with_no_done_tasks_does_nothing
    task = Todo::Task.new('done')
    done_task_list = Todo::TaskList.new
    done_task_list.add_task(task)
    @task_list.add_task(task)

    @task_list.undo

    assert_equal(done_task_list, @task_list.unfinished_tasks)
  end

  def test_done_with_provided_task
    other_task = Todo::Task.new('wash the car')
    original_task = Todo::Task.new('do the dishes')
    @task_list.add_task(other_task)
    @task_list.add_task(original_task)
    done_task = @task_list.done(original_task)
    assert(done_task.done?)
    assert_equal(original_task.description, done_task.description)
  end

  def test_undo_with_provided_task
    other_task = Todo::Task.new('wash the car')
    original_task = Todo::Task.new('do the dishes').done
    @task_list.add_task(other_task)
    @task_list.add_task(original_task)
    unfinished_task = @task_list.undo(original_task)
    refute(unfinished_task.done?)
    assert_equal(original_task.description, unfinished_task.description)
  end
end
