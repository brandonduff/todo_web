require 'test_helper'

module Framework
  class ApplicationTest < Minitest::Test
    class TestComponent < HtmlComponent
      def initialize
        @invoked = false
      end

      def invoke
        @invoked = true
      end

      def invoked?
        @invoked
      end

      def render_content_on(html)
        html.anchor(:invoke)
        html.paragraph("invoked: #{@invoked}")
      end
    end

    def setup
      @continuations = ContinuationDictionary.new
      @application = Application.new(@continuations)
      @test_component = TestComponent.new
      @application.register_root(@test_component)
      @application.call
    end

    def test_rendering
      result = invoke_action(:invoke)
      assert_includes result, 'invoked: true'
    end

    def invoke_action(action)
      @application.call(@continuations.href_for(action))
    end
  end
end