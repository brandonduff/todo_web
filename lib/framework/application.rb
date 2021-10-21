require 'sinatra/base'
require 'active_support/core_ext/hash/indifferent_access'

class Application
  def self.run(component_class)
    set_application(build_application(component_class, Persistence.create))
    start_server
  end

  def self.build_application(component_class, persistence)
    persistence.register_object(component_class.new)
    continuations = ContinuationDictionary.new
    continuations.add_observer(persistence)
    session_store = SessionStore.new(component_class)
    session_store.persistence = persistence
    session_store.continuations = continuations
    instance = new(session_store)
    instance
  end

  def self.set_application(application)
    SinatraServer.set(:application, application)
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

  def initialize(session_store)
    @session_store = session_store
  end

  attr_reader :session_store

  def persistence
    @session_store.persistence
  end

  def continuations
    @session_store.continuations
  end

  def render
    persistence.object.render(continuation_dictionary: continuations)
  end

  def invoke_action(action, *params)
    continuations[action].call(*params) if action
  end

  class SinatraServer < Sinatra::Base
    enable :sessions

    get('/:action') do
      settings.application.invoke_action(params[:action])
      redirect('/')
    end

    get('/') do
      session[:session_id] ||= settings.application.session_store.new_session.id
      settings.application.render
    end

    post('/:action') do
      transformed_params = ActiveSupport::HashWithIndifferentAccess.new(params)
      settings.application.invoke_action(transformed_params[:action], transformed_params.except(:action))
      redirect('/')
    end
  end
end
