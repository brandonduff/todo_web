class HtmlNode
  attr_reader :buffer, :tag_name, :attributes, :inner

  def initialize(tag_name, inner: '', **attributes)
    @tag_name = tag_name
    @attributes = attributes
    @inner = inner
    @block = inner if inner.is_a?(Proc)
  end

  def to_s(canvas)
    @canvas = canvas
    append("<#{tag_name}")

    attributes.each do |key, val|
      attribute_value = val.respond_to?(:call) ? instance_exec(&val) : val
      append(%( #{key}="#{attribute_value}"))
    end

    append(">")

    if @block
      @block.call(@canvas)
    else
      append(inner)
    end

    append("</#{tag_name}>")
  end

  def append(value)
    buffer << value.render
  end

  def buffer
    @canvas.buffer
  end
end
