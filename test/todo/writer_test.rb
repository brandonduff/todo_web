require 'test_helper'

class WriterTest < Minitest::Test
  def test_saving_obj_to_buffer
    writable = 'ima writable'
    Dir.mkdir('tmp') unless Dir.exist?('tmp')
    file_path = 'tmp/test.foo'
    Todo::Writer.for(writable).write_to(file_path)
    assert_equal(writable + "\n", File.read(file_path))
  end
end
