require 'todo'

class Counter < HtmlComponent
  attr_reader :count

  def initialize
    @count = 0
  end

  def increment
    @count += 1
  end

  def decrement
    @count -= 1
  end

  def render_content_on(html)
    html.paragraph(count)
    html.anchor(:increment)
    html.anchor(:decrement)
  end
end

Application.run(Counter)
