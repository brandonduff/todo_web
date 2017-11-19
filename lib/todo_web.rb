require "todo_web/version"
require 'sinatra/base'
require 'todo'

module TodoWeb
  class App < Sinatra::Base
    get '/' do
      Todo::UseCases::ListTodos.new({}).perform
    end
  end
end
