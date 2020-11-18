require 'test_helper'

class TestMoveUpTodoForm < Minitest::Test
  def test_form_action
    form = output.find('form')
    assert_equal 'move_up', form['action']
  end

  def test_button_value
    button = output.find('button', text: "^")
    assert_equal todo, button['value']
  end

  def test_hidden_input
    input = output.find('input[name="todo"]', visible: false)
    assert_equal todo, input['value']
  end

  def test_title
    button = output.find('button')
    assert_equal "Move up some todo", button['title']
  end

  private

  def output
    Capybara.string(MoveUpTodoForm.render(todo))
  end

  def todo
    "some todo"
  end
end

class TestMoveDownTodoForm < Minitest::Test
  def test_form_action
    form = output.find('form')
    assert_equal 'move_down', form['action']
  end

  def test_button_value
    button = output.find('button', text: 'v')
    assert_equal todo, button['value']
  end

  def output
    Capybara.string(MoveDownTodoForm.render(todo))
  end

  def todo
    "some todo"
  end
end
