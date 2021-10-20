require 'yaml/store'

class Persistence
  attr_reader :object, :last_update

  def self.create_null
    new(StoreStub.new)
  end

  def self.create(filename = 'data.yml')
    new(YAML::Store.new(filename))
  end

  def initialize(store)
    @store = store
    @object = @store.transaction(true) { @store[:root] }
  end

  def register_object(component)
    @object = component
  end

  def update
    @store.transaction do
      @store[:root] = @object
    end
    @last_update = @object
  end

  class StoreStub
    def transaction(_read_only = nil)
      yield
    end

    def [](_value)

    end

    def []=(_key, _value)

    end
  end
end