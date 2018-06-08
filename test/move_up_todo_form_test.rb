require 'minitest/autorun'
require 'move_up_todo_form'
require 'capybara'

class TestMoveUpTodoForm < Minitest::Test
  def test_form_action
    form = output.find('form')
    assert_equal 'move_up', form['action']
  end

  def test_button_value
    button = output.find('button')
    assert_equal '1', button['value']
  end

  private

  def output
    Capybara.string(MoveUpTodoForm.render(index))
  end

  def index
    1
  end
end
