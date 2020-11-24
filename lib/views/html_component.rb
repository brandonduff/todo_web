class HtmlComponent
  def render
    canvas = HtmlCanvas.new
    render_content_on(canvas)
    canvas.to_s
  end
end

class HtmlCanvas
  def initialize
    @buffer = ""
  end

  def self.define_tag(method_name, tag = method_name, **default_attributes)
    define_method method_name do |inner_value="", **provided_attributes, &block|
      open_tag(tag, inner: inner_value, **default_attributes, **provided_attributes, &block)
    end
  end

  define_tag :form, method: :post
  define_tag :submit_button, :button, type: :submit
  define_tag :hidden_input, :input, type: :text, hidden: true
  define_tag :paragraph, :p
  define_tag :label
  define_tag :date_input, :input, type: :date
  define_tag :text_input, :input, type: :text
  define_tag :list_item, :li
  define_tag :unordered_list, :ul
  define_tag :div
  define_tag :stylesheet_link, :link, rel: :stylesheet, type: 'text/css'
  define_tag :head
  define_tag :body

  def text(value)
    append(value)
  end

  def to_s
    @buffer
  end

  def render(renderable)
    renderable.render_content_on(self)
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

class Object
  def render
    to_s
  end
end
