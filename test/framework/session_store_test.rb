require 'test_helper'

class SessionStoreTest < Minitest::Test
  def test_retrieving_session
    subject = SessionStore.new
    session = subject.new_session(Object.new)
    other_session = subject.new_session(Object.new)
    assert_equal session, subject.find(session.id)
    assert_equal other_session, subject.find(other_session.id)
    refute_equal session, other_session
  end

  def test_creating_session_accepts_a_component
    subject = SessionStore.new
    component = Object.new
    session = subject.new_session(component)
    assert_equal component, session.component
  end
end