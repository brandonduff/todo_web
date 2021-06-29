class HtmlComponent
  def render(continuation_dictionary: ContinuationDictionary.new)
    continuation_dictionary.register(self)
    canvas = HtmlCanvas.new(continuation_dictionary: continuation_dictionary)
    render_content_on(canvas)
    canvas.to_s
  end
end

class HtmlCanvas
  def initialize(continuation_dictionary:)
    @buffer = ""
    @continuation_dictionary = continuation_dictionary
  end

  def self.define_tag(method_name, tag = method_name, **default_attributes, &definition_block)
    define_method method_name do |inner_value="", **provided_attributes, &block|
      open_tag(tag, inner: inner_value, **default_attributes, **provided_attributes, &block)
      instance_exec(**provided_attributes, &definition_block) if block_given?
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

  def anchor(symbol)
    href = @continuation_dictionary.add(symbol)
    open_tag('a', inner: symbol.to_s, href: href)
  end

  def text(value)
    append(value)
  end

  def to_s
    @buffer
  end

  def render(renderable)
    @continuation_dictionary.register(renderable)
    renderable.render_content_on(self)
  end

  private

  def open_tag(tag_name, inner: "", **attributes)
    append("<#{tag_name}")

    attributes.each do |key, val|
      attribute_value = val.respond_to?(:call) ? instance_exec(&val) : val
      append(%( #{key}="#{attribute_value}"))
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
