require 'minitest/autorun'
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
