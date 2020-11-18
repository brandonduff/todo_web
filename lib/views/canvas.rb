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
  def self.define_tag(method_name, tag = method_name, **default_attributes)
    define_method method_name do |inner_value="", **provided_attributes, &block|
      open_tag(tag, inner: inner_value, **default_attributes, **provided_attributes, &block)
    end
  end

  define_tag :form, method: :post
  define_tag :submit_button, :button, type: :submit
  define_tag :hidden_input, :input, type: :text, hidden: true
  define_tag :paragraph, :p

  def text(value)
    append(value)
  end

  private

  def open_tag(tag_name, inner: "", **attributes)
    append("<#{tag_name}")

    attributes.each do |key, val|
      append(%( #{key}="#{val}"))
    end

    append(">")

    if block_given?
      yield(self)
    else
      append(inner)
    end

    append("</#{tag_name}>")
  end

  def append(value)
    @buffer << value.render
  end
end

class String
  def render
    self
  end
end
