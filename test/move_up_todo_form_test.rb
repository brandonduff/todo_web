require 'minitest/autorun'
require 'move_up_todo_form'
require 'capybara'

class TestMoveUpTodoForm < Minitest::Test
  def test_form_action
    index = 1
    output = Capybara.string(MoveUpTodoForm.render(index))
    form = output.find('form')
    assert_equal 'move_up/1', form['action']
  end
end
