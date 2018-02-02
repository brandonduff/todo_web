module TodoWeb
  class TodoPresenter
    def present(todos)
      todos.map do |todo|
        if todo.done?
          "<del>#{stripped_todo(todo.description)}</del>"
        else
          todo.description
        end
      end
    end

    private

    def stripped_todo(todo)
      todo.delete('✓ ')
    end
  end
end
