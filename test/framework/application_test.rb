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

    def test_web_integration
      Thread.new { Application.run(TestComponent) }
      sleep 0.1 until server_up?
      response = Net::HTTP.get(URI('http://localhost:4567/'))
      assert_includes response, 'invoked: false'
      # todo: post and see invoked change
      # todo: kill server
    end

    def server_up?
      Net::HTTP.get(URI('http://localhost:4567/'))
      true
    rescue Errno::ECONNREFUSED
      false
    end

    def invoke_action(action)
      @application.call(@continuations.href_for(action))
    end
  end
end