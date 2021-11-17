require 'sinatra/base'
require 'active_support/core_ext/hash/indifferent_access'

class Application
  def self.run(component_class)
    set_application(build_application(component_class, Persistence.create))
    start_server
  end

  def self.build_application(component_class, persistence)
    continuations = ContinuationDictionary.new
    continuations.add_observer(persistence)
    session_store = SessionStore.new(component_class, persistence, continuations)
    instance = new(session_store)
    persistence.register_object(component_class.new)
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

  def continuations
    @session_store.continuations
  end

  def render(session)
    session.persistence.object.render(continuation_dictionary: continuations)
  end

  def invoke_action(action, *params)
    continuations[action].call(*params) if action
  end

  class SinatraServer < Sinatra::Base
    enable :sessions

    get('/:action') do
      application.invoke_action(params[:action])
      redirect('/')
    end

    get('/') do
      session[:app_session_id] ||= application.session_store.new_session.id
      application.render(application.session_store.find(session[:app_session_id]))
    end

    post('/:action') do
      transformed_params = ActiveSupport::HashWithIndifferentAccess.new(params)
      application.invoke_action(transformed_params[:action], transformed_params.except(:action))
      redirect('/')
    end

    helpers do
      def application
        settings.application
      end
    end
  end
end
