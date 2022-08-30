require "test_helper"

class TaskListTest < Minitest::Test
  def setup
    @task_list = TaskList.new
  end

  def test_adding_tasks
    task = Task.new("hi")
    @task_list.add_task(task)

    assert_equal(@task_list.to_s, "hi")
  end

  def test_to_s_with_no_tasks
    assert(@task_list.to_s.empty?)
  end

  def test_to_s_with_one_tasks
    @task_list.add_task(Task.new("hi"))

    assert_equal(@task_list.to_s, "hi")
  end

  def test_to_s_with_multiple_tasks
    @task_list.add_task(Task.new("hi"))
    @task_list.add_task(Task.new("guy"))

    assert_equal(@task_list.to_s, "hi\nguy")
  end

  def test_done_on_empty_list_does_nothing
    @task_list.done(Task.new("hi"))
    assert_equal(@task_list.to_s, "")
  end

  def test_done_on_one_task_marks_todo_as_done
    task = Task.new("hi")
    @task_list.add_task(task)
    @task_list.done(task)
    assert_equal("✓ hi", @task_list.to_s)
  end

  def test_clear_on_empty_list_does_nothing
    @task_list.clear
    assert @task_list.empty?
  end

  def test_clear_with_no_done_tasks_does_nothing
    @task_list.add_task(Task.new("hi"))
    @task_list.clear
    assert_equal("hi", @task_list.to_s)
  end

  def test_clear_with_one_done_task_removes_it
    @task_list.add_task(Task.new("hi", true))
    @task_list.add_task(Task.new("not done"))
    @task_list.clear
    assert_equal("not done", @task_list.to_s)
  end

  def test_clear_with_multiple_done_tasks_removes_them
    @task_list.add_task(Task.new("hi", true))
    @task_list.add_task(Task.new("done", true))
    @task_list.add_task(Task.new("not done"))
    @task_list.clear
    assert_equal("not done", @task_list.to_s)
  end

  def test_in_progress_tasks_returns_unfinished_tasks
    done_task = Task.new("done")
    @task_list.add_task(done_task)
    @task_list.done(done_task)
    @task_list.add_task(Task.new("not done"))
    assert_equal("not done", @task_list.unfinished_tasks.to_s)
  end

  def test_undo_with_one_task_undoes_it
    task = Task.new("done")
    done_task_list = TaskList.new
    done_task_list.add_task(Task.new("done"))
    @task_list.add_task(task)
    @task_list.done(task)

    @task_list.undo(task)

    assert_equal(done_task_list, @task_list.unfinished_tasks)
  end

  def test_undo_with_no_done_tasks_does_nothing
    task = Task.new("done")
    done_task_list = TaskList.new
    done_task_list.add_task(task)
    @task_list.add_task(task)

    @task_list.undo(task)

    assert_equal(done_task_list, @task_list.unfinished_tasks)
  end

  def test_done_with_provided_task
    other_task = Task.new("wash the car")
    original_task = Task.new("do the dishes")
    @task_list.add_task(other_task)
    @task_list.add_task(original_task)
    @task_list.done(original_task)
    assert(original_task.done?)
  end

  def test_undo_with_provided_task
    other_task = Task.new("wash the car")
    original_task = Task.new("do the dishes")
    original_task.done
    @task_list.add_task(other_task)
    @task_list.add_task(original_task)
    @task_list.undo(original_task)
    refute(original_task.done?)
  end

  def test_ignores_duplicates
    @task_list << Task.new("do the dishes")
    @task_list << Task.new("do the dishes")
    assert_equal(1, @task_list.count)
  end

  def test_promotion
    @task_list << Task.new("first task")
    last_task = Task.new("second task")
    @task_list << last_task

    @task_list.move(last_task, :up)

    assert_equal last_task, @task_list.first
  end

  def test_demotion
    first_task = Task.new("first task")
    @task_list << first_task
    @task_list << Task.new("second task")
    @task_list << Task.new("third task")

    @task_list.move(first_task, :down)

    assert_equal Task.new("second task"), @task_list.first
  end

  def test_demotion_of_last_task
    first_task = Task.new("first task")
    @task_list << first_task
    @task_list << Task.new("second task")
    third_task = Task.new("third task")
    @task_list << third_task

    @task_list.move(third_task, :down)

    assert_equal third_task, @task_list.first
  end

  def test_promotion_when_task_isnt_in_list
    @task_list.move(Task.new("not in list"), :up)
  end

  def test_promotion_of_first_place_rolls_over
    first_task = Task.new("first task")
    second_task = Task.new("second task")
    @task_list << first_task
    @task_list << second_task

    @task_list.move(first_task, :up)

    assert_equal second_task, @task_list.first
  end

  # observability

  def update(task_list)
    @last_task = task_list.entries.last
  end

  def test_notifies_observers_when_tasks_are_added
    new_task = Task.new("just got added")
    @task_list.add_observer(self)

    @task_list << new_task

    assert_equal new_task, @last_task
  end

  def test_notifies_observers_when_tasks_are_removed
    # flunk 'implement me'
  end

  # notify on remove
  # notify when tasks are moved (maybe on the task themselves?)
  # notify when description is updated (on task)
end
