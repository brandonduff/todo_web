class ContinuationDictionary
  def initialize
    @component_actions = {}
  end

  def [](key)
    @component_actions.fetch(key.to_s)
  end

  def add(symbol)
    # we need to bind to the registered component at this time, not when we end up invoking
    # the proc. this is pretty weird and there must be a better way
    current_component = @registered_component
    @component_actions[href_for(symbol)] = proc do |params|
      if params
        current_component.send(symbol, params)
      else
        current_component.send(symbol)
      end
    end

    href_for(symbol)
  end

  def register(component)
    last_component = @registered_component
    @registered_component = component
    yield
    @registered_component = last_component unless last_component.nil?
  end

  def action
    registered_component.object_id
  end

  def registered_component
    raise 'hi' unless @registered_component
    @registered_component
  end

  def href_for(symbol)
    "#{action}+#{symbol}"
  end

  def has_form?
    @component_actions[href_for('form_submission')]
  end
end
