require "yaml/store"

class Agendas
  include Enumerable

  def self.create_null
    new(StoreWrapperStub.new)
  end

  def self.create(filename)
    new(StoreWrapper.new(filename))
  end

  def initialize(store_wrapper)
    @store_wrapper = store_wrapper
  end

  def current
    entries.first || Agenda.fresh_for_today
  end

  def each(&block)
    entries.each(&block)
  end

  def <<(agenda)
    entries << agenda unless entries.include?(agenda)
    @store_wrapper.write(entries)
  end

  def entries
    @entries ||= @store_wrapper.read || []
  end

  def clear
    @store_wrapper.clear
  end

  class StoreWrapper
    def initialize(filename)
      @store = YAML::Store.new(filename)
    end

    def read
      @store.transaction do
        @store["entries"]
      end
    end

    def write(entries)
      @store.transaction do
        @store["entries"] = entries
      end
    end
  end

  class StoreWrapperStub
    def read
    end

    def write(_entries)
    end

    def clear
    end
  end
end
