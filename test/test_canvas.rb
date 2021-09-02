class TestCanvas < Canvas
  def self.build
    new(continuation_dictionary: ContinuationDictionary.new)
  end

  def self.define_tags(*tags)
    tags.each do |tag|
      define_tag(tag)
    end
  end

  def self.define_tag(tag_name)
    define_method tag_name do |*args, &block|
      if block
        sub_canvas = TestCanvas.build
        rendered[tag_name] << sub_canvas
        block.call(sub_canvas)
      else
        rendered[tag_name] << args.first
      end
    end
  end

  define_tags :list_item, :paragraph, :del, :submit_button, :text

  def include?(content)
    rendered?(content)
  end

  def ==(other)
    include?(other)
  end

  def rendered?(args)
    if args.is_a?(Hash)
      args.all? do |tag, content|
        rendered[tag].include?(content)
      end
    else
      rendered.values.flatten.include?(args)
    end
  end

  def input(attribute, _type)
    value = component.value_for(attribute)
    rendered[:input] << [attribute, value]
  end

  def inputs(name)
    rendered[:input].find(-> { raise 'no input with that name' }) { |k, v| k == name }[1]
  end

  def fill_in(input, value)
    raise 'no form defined' unless @continuation_dictionary.has_form?
    inputs(input) and (params[input] = value)
  end

  def open_tag(*_args)
    yield(self) if block_given?
  end

  def submit
    raise 'no submit button' if rendered[:submit_button].empty?
    component.form_submission(params)
    @rendered = Hash.new { |hash, key| hash[key] = [] }
    render(component)
  end

  def rendered
    @rendered ||= Hash.new { |hash, key| hash[key] = [] }
  end

  private

  def component
    @continuation_dictionary.registered_component
  end

  def params
    @params ||= {}
  end
end