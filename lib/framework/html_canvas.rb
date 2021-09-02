class HtmlCanvas < Canvas
  define_tag :form, method: :post
  define_tag :hidden_input, :input, type: :text, hidden: true
  define_tag :paragraph, :p
  define_tag :label
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

  def input(attribute, type)
    value = @continuation_dictionary.registered_component.value_for(attribute)
    open_tag('input', name: attribute.to_s, type: type, value: value)
  end

  def text(value)
    append(value)
  end

  def to_s
    buffer
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
    buffer << value.render
  end

  def buffer
    @buffer ||= ''
  end
end
