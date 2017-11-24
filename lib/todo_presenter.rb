module TodoWeb
  class TodoPresenter
    def present(todos)
      todos.map do |todo|
        if todo.done
          "<del>#{todo.description}</del>"
        else
          todo.description
        end
      end
    end
  end
end