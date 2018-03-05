module TodoWeb
  class TodoPresenter
    def present(todos)
      EscapedCollection.from(todos).map do |todo|
        if todo.done?
          "<del>#{stripped_todo(todo)}</del>"
        else
          todo.to_s
        end
      end
    end

    private

    def stripped_todo(todo)
      todo.to_s.delete('✓ ')
    end
  end
end
