class ContinuationDictionary
  def initialize
    @component_actions = {}
  end

  def [](key)
    @component_actions[key.to_s]
  end

  def []=(key, value)
    @component_actions[key.to_s] = value
  end

  def add(symbol)
    self[@registered_component.object_id] = -> { @registered_component.send(symbol) }
  end

  def register(component)
    @registered_component = component
  end

  def action
    @registered_component.object_id
  end

  attr_reader :registered_component
end
