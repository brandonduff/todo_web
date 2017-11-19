require "todo_web/version"
require 'sinatra/base'

module TodoWeb
  class App < Sinatra::Base
    get '/' do
      'hello world'
    end
  end
end
