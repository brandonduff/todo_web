class HTMLComponentTest < Minitest::Test
  class RootComponent < HtmlComponent
    def render_content_on(html)
      html.paragraph do
        html.render ChildComponent.new
      end
    end
  end

  class ChildComponent < HtmlComponent
    def render_content_on(html)
      html.text 'child'
    end
  end

  def test_rendering_components
    assert_equal '<p>child</p>', RootComponent.new.render
  end
end

class HTMLCanvasTest < Minitest::Test
  def test_rendering_paragraph
    renderable = Object.new
    def renderable.render_content_on(canvas)
      canvas.paragraph 'hi'
    end

    view = HtmlCanvas.new
    view.render(renderable)

    assert_equal '<p>hi</p>', view.to_s
  end

  def test_simple_block_rendering
    renderable = Object.new
    def renderable.render_content_on(canvas)
      canvas.paragraph { canvas.text 'hi' }
    end

    view = HtmlCanvas.new
    view.render(renderable)

    assert_equal '<p>hi</p>', view.to_s
  end

  def test_rendering_nested_blocks
    renderable = Object.new
    def renderable.render_content_on(canvas)
      canvas.paragraph { canvas.paragraph 'hi' }
    end

    view = HtmlCanvas.new
    view.render(renderable)

    assert_equal '<p><p>hi</p></p>', view.to_s
  end

  def test_rendering_submit_button
    view = HtmlCanvas.new
    view.submit_button(value: 'foo', title: 'title') { |html| html.text('hi') }

    button = find_in_view(view, 'button[type="submit"]')
    assert_equal 'foo', button['value']
    assert_equal 'title', button['title']
    assert_equal 'hi', button.text
  end

  def test_hidden_input
    view = HtmlCanvas.new
    view.hidden_input(name: 'my_name', value: 'my_value')

    input = find_in_view(view, 'input[type="text"]', visible: :hidden)

    assert_equal 'my_name', input['name']
    assert_equal 'my_value', input['value']
    assert input['hidden']
  end

  def test_form
    view = HtmlCanvas.new
    view.form(action: '/my_action') { |html| html.text 'hi' }

    form = find_in_view(view, 'form')
    assert_equal '/my_action', form['action']
    assert_equal 'post', form['method']
    assert_equal 'hi', form.text
  end

  def test_label
    view = HtmlCanvas.new
    view.label 'my label', for: 'my_input'

    label = find_in_view(view, 'label')

    assert_equal 'my label', label.text
    assert_equal 'my_input', label['for']
  end

  def test_date_input
    view = HtmlCanvas.new
    view.date_input name: 'my_date_input'

    input = find_in_view(view, 'input[type="date"]')

    assert_equal 'my_date_input', input['name']
  end

  def test_continuation_form_sets_up_action
    continuation_dictionary = Hash.new
    view = HtmlCanvas.new(continuation_dictionary: continuation_dictionary)
    called = false
    view.continuation_form(action: '/action', callback: -> { called = true }) do |form|
      form.submit_button('Submit')
    end
    form = find_in_view(view, 'form')
    assert_equal '/action', form['action']
    continuation_dictionary['/action'].call
    assert called
  end

  def find_in_view(view, *args, **kwargs)
    result = Capybara.string(view.to_s)
    result.find(*args, **kwargs)
  end
end
