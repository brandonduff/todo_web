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
    @application.call
    Application.set_application(@application)
  end


  def test_web_integration
    get '/'
    assert_includes last_response.body, 'invoked: false'
  end

  def test_sinatra_server_sending_arguments
    get "/#{@continuations.href_for(:invoke)}"
    assert_includes last_response.body, 'invoked: true'
  end

  def test_posting_forms
    post "/#{@continuations.href_for("form_submission")}", { form_attr: 'my form input' }
    assert_includes last_response.body, 'my form input'
  end

  def invoke_action(action)
    @application.call(@continuations.href_for(action))
  end
end
