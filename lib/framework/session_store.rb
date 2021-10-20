require 'ostruct'

class SessionStore
  def initialize
    @sessions = {}
    @id = 1
  end

  def new_session(component)
    OpenStruct.new(id: next_id, component: component).tap do |session|
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