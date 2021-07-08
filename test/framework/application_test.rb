require 'test_helper'
require 'webrick'
require 'rack/test'

class ApplicationTest < Minitest::Test
  include Rack::Test::Methods

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

  def app
    Application
  end

  def setup
    @continuations = ContinuationDictionary.new
    @application = Application.new(@continuations)
    @test_component = TestComponent.new
    @application.register_root(@test_component)
    @application.call
  end


  def test_web_integration
    app = Application.build(TestComponent)
    Application.set_application(app)

    get '/'
    assert_includes last_response.body, 'invoked: false'
  end

  def test_sinatra_server_sending_arguments
    Application.set_application(@application)
    get "http://localhost:4567/#{@continuations.href_for(:invoke)}"
    assert_includes last_response.body, 'invoked: true'
  end

  def invoke_action(action)
    @application.call(@continuations.href_for(action))
  end
end
