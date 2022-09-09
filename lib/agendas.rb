require "yaml/store"

class Agendas
  include Enumerable

  def initialize(filename = "data.store")
    @store = YAML::Store.new(filename)
  end

  def each(&block)
    entries.each(&block)
  end

  def <<(agenda)
    entries << agenda
    @store.transaction do
      @store["entries"] = entries
    end
  end

  def entries
    @entries ||= @store.transaction do
      @store["entries"] || []
    end
  end

  def clear
    @store.transaction do
      @store["entries"] = []
    end
  end
end
