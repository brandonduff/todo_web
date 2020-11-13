module Todo
  module UseCases
    class CreateTodo
      def initialize(todo_text, notepad: Notepad.new)
        @todo_text = todo_text
        @notepad = notepad
      end

      def perform
        task_list = notepad.read_tasks_for_day(notepad.read_current_day)
        task_list.add_task(TaskBuilder.new(@todo_text).build)
        notepad.write_todays_tasks(task_list)
      end

      attr_reader :notepad
    end
  end
end
