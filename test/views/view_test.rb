require 'views/view'

class ViewTest < Minitest::Test
  class StringView < View
    def initialize
      @buffer = ""
    end

    def print(string)
      @buffer << "hi"
    end

    def to_s
      @buffer
    end
  end

  def test_basic_rendering_double_dispatch
    view = StringView.new
    renderable = Object.new
    def renderable.render_content_on(canvas)
      canvas.print("hi")
    end

    view.render renderable

    assert_equal(view.to_s, "hi")
  end
end
