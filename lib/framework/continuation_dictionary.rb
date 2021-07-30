class ContinuationDictionary
  def initialize
    @component_actions = {}
  end

  def [](key)
    @component_actions[key.to_s]
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
    @last_component = @registered_component
    @registered_component = component
    yield
    @registered_component = @last_component
    @last_component = component
  end

  def action
    if @registered_component
      @registered_component.object_id
    else
      @last_component.object_id
    end
  end

  attr_reader :registered_component, :last_component

  def href_for(symbol)
    "#{action}+#{symbol}"
  end

  def has_form?
    @component_actions[href_for('form_submission')]
  end
end
