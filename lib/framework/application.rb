require 'sinatra/base'
require 'active_support/core_ext/hash/indifferent_access'

class Application
  def self.run(component_class)
    set_application(build(component_class))
    start_server
  end

  def self.build(component_class)
    instance = new(ContinuationDictionary.new)
    instance.register_root(component_class.new)
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

  def initialize(continuations)
    @continuations = continuations
  end

  def register_root(component)
    @root = component
  end

  def call(action = nil, *params)
    @continuations[action].call(*params) if action
    @root.render(continuation_dictionary: @continuations)
  end

  class SinatraServer < Sinatra::Base
    get('/:action') { settings.application.call(params[:action]) }
    get('/') { settings.application.call }
    post('/:action') do
      transformed_params = ActiveSupport::HashWithIndifferentAccess.new(params)
      settings.application.call(transformed_params[:action], transformed_params.except(:action))
      redirect('/')
    end
  end
end
