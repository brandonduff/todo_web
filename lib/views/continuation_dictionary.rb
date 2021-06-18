class ContinuationDictionary
  def initialize
    @component_actions = {}
  end

  def [](key)
    @component_actions[key.to_s]
  end

  def add(symbol)
    @component_actions[href_for(symbol)] = -> { @registered_component.send(symbol) }
    href_for(symbol)
  end

  def register(component)
    @registered_component = component
  end

  def action
    @registered_component.object_id
  end

  attr_reader :registered_component

  private

  def href_for(symbol)
    "#{action}+#{symbol}"
  end
end
