class ContinuationDictionary
  def initialize
    @component_actions = {}
  end

  def [](key)
    @component_actions[key.to_s]
  end

  def add(symbol, component)
    # we need to bind to the registered component at this time, not when we end up invoking
    # the proc. this is pretty weird and there must be a better way
    current_component = component
    @component_actions[href_for(symbol, current_component)] = proc do |params|
      if params
        current_component.send(symbol, params)
      else
        current_component.send(symbol)
      end
    end

    href_for(symbol, component)
  end

  def register(component)
    last_component = @registered_component
    @registered_component = component
    yield
    @registered_component = last_component
  end

  attr_reader :registered_component

  def href_for(symbol, component)
    "#{action(component)}+#{symbol}"
  end

  def has_form?(component)
    @component_actions[href_for('form_submission', component)]
  end

  private

  def action(component)
    component.object_id
  end
end
