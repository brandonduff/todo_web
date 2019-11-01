require 'rack/utils'

module TodoWeb
  class TodoPresenter
    def present(todos)
      todos.map do |todo|
        TodoViewModel.new(description: description(todo))
      end
    end

    def escape(text)
      Rack::Utils.escape_html(text)
    end

    TodoViewModel = Struct.new(:description, keyword_init: true)
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
