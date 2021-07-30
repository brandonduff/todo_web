require 'test_helper'
require 'webrick'
require 'rack/test'
ENV['APP_ENV'] = 'test'

class ApplicationTest < Minitest::Test
  include Rack::Test::Methods

  class TestComponent < HtmlComponent
    attr_accessor :form_attr

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
      html.new_form
      html.paragraph("form_attr: #{form_attr}")
    end
  end

  def app
    Application
  end

  def setup
    @continuations = ContinuationDictionary.new
    @application = Application.new(@continuations)
    @test_component = TestComponent.new
    @application.register_root(@test_component)
    Application.set_application(@application)
    get '/' # initial render to register continuations
  end

  def test_web_integration
    assert_includes last_response.body, 'invoked: false'
    get "/#{@continuations.href_for(:invoke, @test_component)}"
    follow_redirect!
    assert_includes last_response.body, 'invoked: true'
    assert_equal 'http://example.org/', last_request.url
  end

  def test_posting_forms
    post "/#{@continuations.href_for("form_submission", @test_component)}", { form_attr: 'my form input' }
    follow_redirect!
    assert_includes last_response.body, 'my form input'
    assert_equal 'http://example.org/', last_request.url
  end

  def invoke_action(action)
    @application.call(@continuations.href_for(action, @test_component))
  end
end
