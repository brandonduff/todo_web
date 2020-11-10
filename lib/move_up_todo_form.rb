class HTMLRenderer
  def initialize(*args)
    @buffer = ""
  end

  def form(action:, &block)
    append %(<form action="#{action}" method="post">)
    instance_eval(&block)
    @buffer << %(</form>)
  end

  def submit_button(value:, title:, &block)
    append %(<button type="submit" value="#{value}" title="#{title}">)
    instance_eval(&block)
    append %(</button>)
  end

  def text(text)
    append text
  end

  def hidden_input(value:, name:)
    append %(<input type="text" name="#{name}" value="#{value}" hidden />)
  end

  def to_s
    @buffer
  end

  private

  def append(string)
    @buffer << string
  end
end

class MoveUpTodoForm < HTMLRenderer
  def self.render(todo)
    new(todo).render
  end

  def initialize(todo)
    super
    @todo = todo
  end

  def render
    form(action: action) do
      hidden_input(value: todo, name: "todo")
      submit_button(value: todo, title: title) do
        text(button_text)
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
