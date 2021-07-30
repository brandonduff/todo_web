require 'test_helper'

class ContinuationDictionaryTest < Minitest::Test
  def component_for_test
    Class.new(HtmlComponent) do
      attr_accessor :attr
    end.new
  end

  def test_handling_multiple_forms
    first_component = component_for_test
    second_component = component_for_test
    subject = ContinuationDictionary.new

    first_key = nil
    subject.register(first_component) do
      first_key = subject.add('form_submission', first_component)
    end
    subject.register(second_component) do
      subject.add('form_submission', second_component)
    end
    subject[first_key].call(attr: 'first component attr')

    assert_nil second_component.attr
    assert_equal 'first component attr', first_component.attr
  end

  def test_register_resetting_component_after_yielding
    first_component = component_for_test
    second_component = component_for_test
    subject = ContinuationDictionary.new

    subject.register(first_component) do
      assert_equal first_component, subject.registered_component
      subject.register(second_component) do
        assert_equal second_component, subject.registered_component
      end
      assert_equal first_component, subject.registered_component
    end
  end
end