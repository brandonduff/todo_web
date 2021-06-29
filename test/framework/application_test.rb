require 'test_helper'
require 'webrick'

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
    Application::SinatraServer.set :server_settings, Logger: WEBrick::Log.new(File.open(File::NULL, 'w')), AccessLog: []
    Application::SinatraServer.set :quiet, true
    Application::SinatraServer.set :logging, false
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
    app = Application.build(TestComponent)
    Application.set_application(app)

    with_server_running_application do
      response = Net::HTTP.get(URI('http://localhost:4567/'))
      assert_includes response, 'invoked: false'
    end
  end

  def test_sinatra_server_sending_arguments
    Application.set_application(@application)
    with_server_running_application do
      response = Net::HTTP.get(URI("http://localhost:4567/#{@continuations.href_for(:invoke)}"))
      assert_includes response, 'invoked: true'
    end
  end

  def invoke_action(action)
    @application.call(@continuations.href_for(action))
  end

  private

  def with_server_running_application
    Thread.new { Application.start_server }
    wait_for_server
    yield
    Application.stop
  end

  def wait_for_server
    Timeout.timeout(3, StandardError, 'server never came up') do
      sleep 0.1 until server_up?
    end
  end

  def server_up?
    Net::HTTP.get(URI('http://localhost:4567/'))
    true
  rescue Errno::ECONNREFUSED
    false
  end
end
