require 'sinatra/base'
require 'active_support/core_ext/hash/indifferent_access'

class Application
  def self.run(component_class)
    set_application(build(component_class))
    start_server
  end

  def self.build(component_class)
    persistence = Persistence.create
    instance = new(ContinuationDictionary.new, persistence)
    instance.register_root(persistence.object || component_class.new)
    instance
  end

  def self.set_application(application)
    SinatraServer.set(:application, application)
    SinatraServer.set(:sessions, SessionStore.new)
  end

  def self.stop
    SinatraServer.stop!
  end

  def self.start_server
    SinatraServer.run!
  end

  def self.call(*params, &block)
    SinatraServer.call(*params, &block)
  end

  def initialize(continuations, persistence)
    @continuations = continuations
    @persistence = persistence
    @continuations.add_observer(@persistence)
  end

  def register_root(component)
    @persistence.register_object(component)
  end

  def render
    @persistence.object.render(continuation_dictionary: @continuations)
  end

  def invoke_action(action, *params)
    @continuations[action].call(*params) if action
  end

  class SinatraServer < Sinatra::Base
    enable :sessions

    get('/:action') do
      settings.application.invoke_action(params[:action])
      redirect('/')
    end

    get('/') do
      # todo: make this a new component, not new blank object for new session
      session[:session_id] ||= settings.sessions.new_session(Object.new).id
      settings.application.render
    end

    post('/:action') do
      transformed_params = ActiveSupport::HashWithIndifferentAccess.new(params)
      settings.application.invoke_action(transformed_params[:action], transformed_params.except(:action))
      redirect('/')
    end
  end
end
