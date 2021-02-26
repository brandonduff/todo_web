require 'test_helper'

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
    view = new_component do |canvas|
      canvas.paragraph 'hi'
    end

    assert_equal '<p>hi</p>', view.render
  end

  def test_simple_block_rendering
    view = new_component do |html|
      html.paragraph { html.text 'hi' }
    end

    assert_equal '<p>hi</p>', view.render
  end

  def test_rendering_nested_blocks
    view = new_component do |canvas|
      canvas.paragraph { canvas.paragraph 'hi' }
    end

    assert_equal '<p><p>hi</p></p>', view.render
  end

  def test_rendering_submit_button
    view = new_component do |html|
      html.submit_button(value: 'foo', title: 'title') { |html| html.text('hi') }
    end

    button = find_in_view(view, 'button[type="submit"]')
    assert_equal 'foo', button['value']
    assert_equal 'title', button['title']
    assert_equal 'hi', button.text
  end

  def test_hidden_input
    view = new_component do |html|
      html.hidden_input(name: 'my_name', value: 'my_value')
    end

    input = find_in_view(view, 'input[type="text"]', visible: :hidden)

    assert_equal 'my_name', input['name']
    assert_equal 'my_value', input['value']
    assert input['hidden']
  end

  def test_form
    view = new_component do |html|
      html.form(action: '/my_action') { |html| html.text 'hi' }
    end

    form = find_in_view(view, 'form')
    assert_equal '/my_action', form['action']
    assert_equal 'post', form['method']
    assert_equal 'hi', form.text
  end

  def test_label
    view = new_component do |html|
      html.label 'my label', for: 'my_input'
    end

    label = find_in_view(view, 'label')

    assert_equal 'my label', label.text
    assert_equal 'my_input', label['for']
  end

  def test_date_input
    view = new_component do |html|
      html.date_input name: 'my_date_input'
    end

    input = find_in_view(view, 'input[type="date"]')

    assert_equal 'my_date_input', input['name']
  end

  def test_continuation_form_calling_method_on_component
    continuation_dictionary = ContinuationDictionary.new
    component = Class.new(HtmlComponent) do
      def call_me!
        @called = true
      end

      def render_content_on(html)
        html.continuation_form(callback: :call_me!) do |form|
          form.submit_button('Submit')
        end
      end

      attr_reader :called
    end.new

    action = find_in_view(component.render(continuation_dictionary: continuation_dictionary), 'form')['action']
    continuation_dictionary[action].call
    assert component.called
  end

  def new_component
    Class.new(HtmlComponent) do
      define_method :render_content_on do |html|
        yield(html)
      end
    end.new
  end

  def find_in_view(view, *args, **kwargs)
    result = Capybara.string(view.render)
    result.find(*args, **kwargs)
  end

  def test_registering_component
    dictionary = ContinuationDictionary.new
    object = 42
    dictionary.register(object)
    dictionary.add(:to_s)
    assert_equal '42', dictionary[object.object_id.to_s].call
  end
end
