require 'test_helper'

class SessionStoreTest < Minitest::Test
  def test_retrieving_session
    subject = SessionStore.new
    session = subject.new_session
    other_session = subject.new_session
    assert_equal session, subject.find(session.id)
    assert_equal other_session, subject.find(other_session.id)
    refute_equal session, other_session
  end
end