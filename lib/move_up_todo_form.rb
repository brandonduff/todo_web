class HTMLRenderer
  def initialize(*args)
    @buffer = ""
  end

  def form(action:, &block)
    @buffer << %(<form action="#{action}" method="post">)
    instance_eval(&block)
    @buffer << %(</form>)
  end

  def submit_button(value:, title:, &block)
    @buffer << %(<button type="submit" value="#{value}" title="#{title}">)
    instance_eval(&block)
    @buffer << %(</button>)
  end

  def text(text)
    @buffer << text
  end

  def hidden_input(value:, name:)
    @buffer << %(<input type="text" name="#{name}" value="#{value}" hidden />)
  end

  def to_s
    @buffer
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
    form(action: "move_up") do
      hidden_input(value: todo, name: "todo")
      submit_button(value: todo, title: "Move up #{todo}") do
        text("^")
      end
    end
  end

  private

  attr_reader :todo
end
