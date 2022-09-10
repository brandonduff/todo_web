require "yaml/store"

class Agendas
  include Enumerable

  def self.create_null
    new("test_data.store", null: true)
  end

  def initialize(filename = "data.store", null: false)
    @store_wrapper = null ? StoreWrapperStub.new : StoreWrapper.new(filename)
    @null = null
  end

  def current
    entries.first || Agenda.fresh_for_today
  end

  def each(&block)
    entries.each(&block)
  end

  def <<(agenda)
    entries << agenda
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

    def clear
      @store.transaction do
        @store["entries"] = []
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
