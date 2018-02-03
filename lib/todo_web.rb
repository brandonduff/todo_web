require "todo_web/version"
require 'sinatra/base'
require 'todo'
require 'todo_presenter'

module TodoWeb
  class App < Sinatra::Base
    get '/' do
      erb :index, locals: {
        todos: Todo::UseCases::ListTodos.new(presenter: TodoPresenter.new, all: true).perform,
        current_day: Date.parse(Todo::UseCases::SetCurrentDay.new({}).perform),
      }
    end

    post '/' do
      Todo::UseCases::CreateTodo.new(params["todo"]).perform
      redirect(root)
    end

    post '/done' do
      Todo::UseCases::Done.new.perform
      redirect(root)
    end

    post '/clear' do
      Todo::UseCases::Clear.new.perform
      redirect(root)
    end

    private

    def root
      '/'
    end
  end
end
