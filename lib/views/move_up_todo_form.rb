class MoveUpTodoForm < HTMLComponent
  def self.render(todo)
    new(todo).render
  end

  def initialize(todo)
    @todo = todo
  end

  def render_content_on(html)
    html.form(action: action) do
      html.hidden_input(value: todo, name: "todo")
      html.submit_button(value: todo, title: title) do
        html.text(button_text)
      end
    end
  end

  private

  def action
    "move_#{direction}"
  end

  def direction
    :up
  end

  def title
    "Move #{direction} #{todo}"
  end

  def button_text
    direction == :up ? "^" : "v"
  end

  attr_reader :todo
end

class MoveDownTodoForm < MoveUpTodoForm
  def direction
    :down
  end
end
