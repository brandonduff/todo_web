class Canvas
  def initialize
    @buffer = ""
  end

  def render(renderable)
    renderable.render_content_on(self)
  end

  def to_s
    @buffer
  end
end

class HTMLCanvas < Canvas
  def paragraph(value=nil)
    append("<p>")

    if block_given?
      yield(self)
    else
      append(value)
    end

    append("</p>")
  end

  def submit_button(value:, title:)
    append(%(<button type="submit" value="#{value}" title="#{title}">))
    yield(self)
    append('</button>')
  end

  def text(value)
    append(value)
  end

  private

  def append(value)
    @buffer << value.render
  end
end

class String
  def render
    self
  end
end
