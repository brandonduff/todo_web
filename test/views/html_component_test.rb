require 'test_helper'

class HTMLComponentTest < Minitest::Test
  class RootComponent < HtmlComponent
    def initialize(child_component)
      @child_component = child_component
    end

    def render_content_on(html)
      html.paragraph do
        html.render @child_component
      end
    end
  end

  class ChildComponent < HtmlComponent
    def render_content_on(html)
      html.text 'child'
    end
  end

  def test_rendering_components
    assert_equal '<p>child</p>', RootComponent.new(ChildComponent.new).render
  end

  def test_continuation_dictionary_passed_between_components
    continuation_dictionary = ContinuationDictionary.new
    child_component = ChildComponent.new
    component = RootComponent.new(child_component)
    component.render(continuation_dictionary: continuation_dictionary)
    assert_equal child_component, continuation_dictionary.registered_component
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

  class Counter < HtmlComponent
    attr_reader :count

    def initialize
      @count = 0
    end

    def increment
      @count += 1
    end

    def decrement
      @count -= 1
    end

    def render_content_on(html)
      html.paragraph(count)
      html.anchor(:increment)
      html.anchor(:decrement)
    end
  end

  def test_component_with_single_callback
    dictionary = ContinuationDictionary.new
    component = Counter.new

    result = Capybara.string(component.render(continuation_dictionary: dictionary))
    assert_equal "0", result.find('p').text

    click_link('increment', result, dictionary)

    result = Capybara.string(component.render)
    assert_equal "1", result.find('p').text
  end

  def test_component_with_multiple_callbacks
    dictionary = ContinuationDictionary.new
    component = Counter.new

    component.increment

    result = Capybara.string(component.render(continuation_dictionary: dictionary))
    assert_equal "1", result.find('p').text

    click_link('decrement', result, dictionary)

    result = Capybara.string(component.render)
    assert_equal "0", result.find('p').text
  end

  class TestFormComponent < HtmlComponent
    attr_accessor :attr

    def render_content_on(html)
      html.new_form do |f|
        f.text_input(:attr)
      end
    end
  end

  def test_form
    dictionary = ContinuationDictionary.new
    component = TestFormComponent.new
    result = Capybara.string(component.render(continuation_dictionary: dictionary))
    action = result.find('form')['action']
    dictionary[action].call(attr: 'attr set')
    assert_equal 'attr set', component.attr
  end

  def form_submission
    @form_submitted = true
  end

  def click_link(text, html, continuations)
    href = html.find('a', text: text)['href']
    continuations[href].call
  end
end
