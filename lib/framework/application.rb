require 'sinatra/base'

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

  def call(action = nil)
    @continuations[action].call if action
    @root.render(continuation_dictionary: @continuations)
  end

  class SinatraServer < Sinatra::Base
    get('/:action') { settings.application.call(params[:action]) }
    get('/') { settings.application.call }
  end
end
