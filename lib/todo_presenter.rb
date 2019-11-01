require 'rack/utils'

module TodoWeb
  class TodoPresenter
    def present(todos)
      todos.map do |todo|
        description = description(todo)
        TodoViewModel.new(description: description, done_action: "/done/#{URI::escape(description)}")
      end
    end

    def escape(text)
      Rack::Utils.escape_html(text)
    end

    TodoViewModel = Struct.new(:description, :done_action, keyword_init: true)

    private

    def description(todo)
      if todo.done?
        "<del>#{escape(todo.description)}</del>"
      else
        escape(todo.description)
      end
    end
  end
end
