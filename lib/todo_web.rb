require "todo_web/version"
require 'sinatra/base'
require 'todo'
require 'todo_presenter'

module TodoWeb
  class App < Sinatra::Base
    get '/' do
      list_todos
    end

    post '/' do
      Todo::UseCases::CreateTodo.new(params["todo"]).perform
      list_todos
    end

    post '/done' do
      Todo::UseCases::Done.new.perform
      list_todos
    end

    private

    def list_todos
      erb :index, locals: { todos: Todo::UseCases::ListTodos.new(presenter: TodoPresenter.new, all: true).perform }
    end
  end
end
