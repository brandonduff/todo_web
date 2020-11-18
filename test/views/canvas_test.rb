require 'minitest/autorun'
require 'capybara'
require 'views/canvas'

class CanvasTest < Minitest::Test
  class StringView < Canvas
    def print(string)
      @buffer << "hi"
    end
  end

  def test_basic_rendering_double_dispatch
    view = StringView.new
    renderable = Object.new

    def renderable.render_content_on(canvas)
      canvas.print("hi")
    end

    view.render renderable

    assert_equal view.to_s, "hi"
  end
end

class HTMLCanvasTest < Minitest::Test
  def test_rendering_paragraph
    renderable = Object.new
    def renderable.render_content_on(canvas)
      canvas.paragraph 'hi'
    end

    view = HTMLCanvas.new
    view.render(renderable)

    assert_equal '<p>hi</p>', view.to_s
  end

  def test_simple_block_rendering
    renderable = Object.new
    def renderable.render_content_on(canvas)
      canvas.paragraph { canvas.text 'hi' }
    end

    view = HTMLCanvas.new
    view.render(renderable)

    assert_equal '<p>hi</p>', view.to_s
  end

  def test_rendering_nested_blocks
    renderable = Object.new
    def renderable.render_content_on(canvas)
      canvas.paragraph { canvas.paragraph 'hi' }
    end

    view = HTMLCanvas.new
    view.render(renderable)

    assert_equal '<p><p>hi</p></p>', view.to_s
  end

  def test_rendering_submit_button
    view = HTMLCanvas.new
    view.submit_button(value: 'foo', title: 'title') { |html| html.text('hi') }

    result = Capybara.string(view.to_s)

    button = result.find('button[type="submit"]')
    assert_equal 'foo', button['value']
    assert_equal 'title', button['title']
    assert_equal 'hi', button.text
  end

  def test_hidden_input
    view = HTMLCanvas.new
    view.hidden_input(name: 'my_name', value: 'my_value')

    result = Capybara.string(view.to_s)
    input = result.find('input[type="text"]', visible: :hidden)

    assert_equal 'my_name', input['name']
    assert_equal 'my_value', input['value']
    assert input['hidden']
  end
end

class ComponentTest < Minitest::Test
  class RootComponent
    def render_content_on(html)
      html.paragraph do
        html.render ChildComponent.new
      end
    end
  end

  class ChildComponent
    def render_content_on(html)
      html.text 'child'
    end
  end

  def test_rendering_components
    canvas = HTMLCanvas.new
    canvas.render(RootComponent.new)
    assert_equal '<p>child</p>', canvas.to_s
  end
end
