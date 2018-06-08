class MoveUpTodoForm
  def self.render(index)
    new(index).render
  end

  def initialize(index)
    @index = index
  end

  def render
    %(<form action="move_up" method="post"><button type="submit" value="#{index}" title="Move up #{index}>">^</button></form>)
  end

  private

  attr_reader :index
end
