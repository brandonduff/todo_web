require 'test_helper'

class PersistenceTest < Minitest::Test
  def test_persisting_across_instances
    subject = Persistence.create('test_data.yml')
    subject.register_component('hi')
    subject.update
    assert_equal 'hi', Persistence.create('test_data.yml').component
    FileUtils.rm('test_data.yml')
  end

  def test_nullability
    subject = Persistence.create_null
    subject.register_component('should be null')
    subject.update
    refute_equal 'should be null', Persistence.create.component
  end

  def test_retrieving_last_updated_state
    subject = Persistence.create_null
    subject.register_component('last update')
    subject.update
    assert_equal 'last update', subject.last_update
  end
end