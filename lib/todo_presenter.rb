require 'rack/utils'

module TodoWeb
  class TodoPresenter
    def present(todos)
      todos.map do |todo|
        if todo.done?
          "<del>#{escape(todo.description)}</del>"
        else
          escape(todo.description)
        end
      end
    end

    def escape(text)
      Rack::Utils.escape_html(text)
    end
  end
end
