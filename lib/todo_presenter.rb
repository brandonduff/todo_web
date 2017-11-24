module TodoWeb
  class TodoPresenter
    def present(todos)
      todos.map do |todo|
        if todo.done
          "<del>#{todo.value}</del>"
        else
          todo.value
        end
      end
    end
  end
end