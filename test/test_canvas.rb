class TestCanvas < Canvas
  def self.build
    new(continuation_dictionary: ContinuationDictionary.new)
  end

  def paragraph(*args, &block)
    rendered[:paragraph] << args.first
  end

  def rendered?(args)
    rendered[:paragraph].include?(args[:paragraph])
  end

  def input(attribute, _type)
    rendered[:input] << [attribute, component.send(attribute)]
  end

  def inputs(name)
    rendered[:input].find { |k, v| k == name }[1]
  end

  def fill_in(input, value)
    params[input] = value
  end

  def open_tag(*_args)
    yield(self) if block_given?
  end

  def submit
    component.form_submission(params)
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