require 'test_helper'

class PersistenceTest < Minitest::Test
  def test_persisting_across_instances
    subject = Persistence.create('test_data.yml')
    subject.register_object('hi')
    subject.update
    assert_equal 'hi', Persistence.create('test_data.yml').object
    FileUtils.rm('test_data.yml')
  end

  def test_nullability
    subject = Persistence.create_null
    subject.register_object('should be null')
    subject.update
    refute_equal 'should be null', Persistence.create('test_data.yml').object
  end

  def test_retrieving_last_updated_state
    subject = Persistence.create_null
    subject.register_object('last update')
    subject.update
    assert_equal 'last update', subject.last_update
  end
end