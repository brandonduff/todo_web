class Canvas
  def self.define_tag(method_name, tag = method_name, **default_attributes, &definition_block)
    define_method method_name do |inner_value="", **provided_attributes, &block|
      open_tag(tag, inner: inner_value, **default_attributes, **provided_attributes, &block)
      instance_exec(**provided_attributes, &definition_block) if block_given?
    end
  end

  define_tag :submit_button, :button, type: :submit
  define_tag :list_item, :li
  define_tag :unordered_list, :ul

  def initialize(continuation_dictionary:)
    @continuation_dictionary = continuation_dictionary
  end

  def render(renderable)
    old = @current_component
    @current_component = renderable
    @last_component = @current_component
    renderable.render_content_on(self)
    @current_component = old
  end

  def new_form(&block)
    action = @continuation_dictionary.add('form_submission', @current_component)
    open_tag('form', action: action, method: 'post', &block)
  end

  def text_input(attribute)
    input(attribute, 'text')
  end

  def date_input(attribute)
    input(attribute, 'date')
  end
end