require 'test_helper'

class TaskBuilderTest < Minitest::Test
  def test_no_checkmark_builds_undone_task
    description = 'I am not done'
    expected_task = Todo::Task.new('I am not done')

    assert_equal(expected_task, Todo::TaskBuilder.new(description).build)
  end

  def test_checkmark_builds_done_task_without_checkmark_in_description
    description = '✓ I am not done'
    expected_task = Todo::Task.new('I am not done', true)

    assert_equal(expected_task, Todo::TaskBuilder.new(description).build)
  end
end
