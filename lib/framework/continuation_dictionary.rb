class ContinuationDictionary
  def initialize
    @component_actions = {}
  end

  def [](key)
    @component_actions.fetch(key.to_s)
  end

  def add(symbol, &block)
    continuation = Continuation.new(@registered_component, block || symbol)
    continuation.add_observer(@observer)
    @component_actions[href_for(symbol)] = continuation

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
    @registered_component
  end

  def href_for(symbol)
    "#{action}+#{symbol}"
  end

  def has_form?
    @component_actions[href_for('form_submission')]
  end

  def add_observer(observer)
    @observer = observer
  end

  private

  class Continuation
    def initialize(component, block_or_symbol)
      @component = component
      @block_or_symbol = block_or_symbol
    end

    def call(*args)
      invoke(args)
      notify_observers
    end

    def add_observer(observer)
      @observer = observer
    end

    private

    def invoke(args)
      if @block_or_symbol.is_a?(Proc)
        @block_or_symbol.call(@component, *args)
      else
        @component.send(@block_or_symbol, *args)
      end
    end

    def notify_observers
      @observer.update if @observer
    end
  end
end
