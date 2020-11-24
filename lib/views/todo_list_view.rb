class TodoListView < HtmlComponent
  def initialize(todos)
    @todos = todos
  end

  def render_content_on(html)
    html.unordered_list do
      @todos.each do |todo|
        html.list_item do
          html.text todo.description
          html.form(action: todo.done_action) do
            html.submit_button 'Done'
          end
          html.render MoveUpTodoForm.new(todo.description)
          html.render MoveDownTodoForm.new(todo.description)
        end
      end
    end

    html.div class: :actions do
      html.form action: '/undo' do
        html.submit_button 'Undo'
      end

      html.form action: '/clear' do
        html.submit_button 'Clear'
      end
    end
  end
end
