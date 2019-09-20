require 'test_helper'

module Todo
  class PersistenceTest < Minitest::Test

    def setup
      @task_list = Todo::TaskList.new(StringIO.new)
      @writer = double('Writer')
      @reader = double('Reader')
      @env_helper = double('EnvHelper')
      @current_day = '1=1=2000'
      @current_day_path = '/path/1-1-2000'
      @todo_path = 'todo-path'
      @task_data = %w(task for day)
      allow(EnvHelper).to receive(:new).and_return(@env_helper)
      allow(Writer).to receive(:for).with(@task_list).and_return(@writer)
      allow(Reader).to receive(:new).with(@env_helper).and_return(@reader)
      allow(@reader).to receive(:current_day).and_return(@current_day)
      allow(@reader).to receive(:task_data_for_day).with(@current_day).and_return(@task_data)
      allow(@env_helper).to receive(:current_day_path).and_return(@current_day_path)
      allow(@env_helper).to receive(:todo_file_for_day).with(@current_day).and_return(@todo_path)
      allow(@env_helper).to receive(:todo_path).and_return('/tmp/todo')
    end

    def test_task_list_writer
      expect(@writer).to receive(:write_to).with(@todo_path)
      task_list_writer = Persistence.new
      task_list_writer.write_todays_tasks('foo')
    end

    def test_writing_ensure_todo_dir_exists
      allow(@writer).to receive(:write_to).with(@todo_path)
      Dir.rmdir(@env_helper.todo_path) if Dir.exist?(@env_helper.todo_path)

      Persistence.new.write_todays_tasks('foo')

      assert(Dir.exist?(@env_helper.todo_path))
    end

    def test_write_current_day
      expect(@writer).to receive(:write_to).with(@current_day_path)
      Persistence.new.write_current_day('1-1-2000')
    end

    def test_read_tasks_for_day
      expected_task_list = TaskList.new.tap do |task_list|
        @task_data.each do |task|
          task_list.add_task(TaskBuilder.new(task).build)
        end
      end

      assert_equal(expected_task_list, Persistence.new.read_tasks_for_day(@current_day))
    end

    def test_read_current_day
      assert_equal(@current_day, Persistence.new.read_current_day)
    end
  end
end
