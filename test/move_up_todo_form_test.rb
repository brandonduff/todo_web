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
    assert_equal todo, button['value']
  end

  def test_hidden_input
    input = output.find('input[name="todo"]', visible: false)
    assert_equal todo, input['value']
  end

  private

  def output
    Capybara.string(MoveUpTodoForm.render(todo))
  end

  def todo
    "some todo"
  end
end
