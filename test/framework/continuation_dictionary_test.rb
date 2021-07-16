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

    subject.register(first_component)
    first_key = subject.add('form_submission')
    subject.register(second_component)
    subject.add('form_submission')
    subject[first_key].call(attr: 'first component attr')

    assert_nil second_component.attr
    assert_equal 'first component attr', first_component.attr
  end
end