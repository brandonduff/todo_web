class TestCanvas < Canvas
  def self.build
    new(continuation_dictionary: ContinuationDictionary.new)
  end

  def paragraph(*args, &block)
    rendered[:paragraph] << args.first
  end

  def list_item(*args, &block)
    rendered[:list_item] << args.first
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

  def submit_button(*args)
    rendered[:submit_button] << args.first
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