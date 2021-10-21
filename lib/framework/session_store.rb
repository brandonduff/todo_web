require 'ostruct'

class SessionStore
  attr_accessor :persistence, :continuations

  def initialize(component_factory, persistence, continuations)
    @sessions = {}
    @id = 1
    @component_factory = component_factory
    @persistence = persistence
    @continuations = continuations
  end

  def new_session
    OpenStruct.new(id: next_id, component: @component_factory.new, continuations: continuations, persistence: persistence).tap do |session|
      @sessions[session.id] = session
    end
  end

  def find(id)
    @sessions[id]
  end

  private

  def next_id
    @id += 1
  end
end