class Agendas
  include Enumerable

  def self.entries
    @entries ||= []
  end

  def self.clear
    @entries = []
  end

  def each(&block)
    entries.each(&block)
  end

  def <<(agenda)
    entries << agenda
  end

  def entries
    self.class.entries
  end
end