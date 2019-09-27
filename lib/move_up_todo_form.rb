class HTMLRenderer
  def form(action:, &block)
    <<~FORM
      <form action="#{action}" method="post">
        #{instance_eval(&block)}
      </form>
    FORM
  end

  def submit_button(value:, title:, &block)
    <<~BTN
      <button type="submit" value="#{value}" title="#{title}">
        #{instance_eval(&block)}
      </button>
    BTN
  end
end

class MoveUpTodoForm < HTMLRenderer
  def self.render(index)
    new(index).render
  end

  def initialize(index)
    @index = index
  end

  def render
    form(action: "move_up") do
      submit_button(value: index, title: "Move up #{index}") { "^" }
    end
  end

  private

  attr_reader :index
end
