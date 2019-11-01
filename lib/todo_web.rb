require "todo_web/version"
require 'sinatra/base'
require 'todo'
require 'todo_presenter'
require 'move_up_todo_form'

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

    post '/done/:task' do
      Todo::UseCases::Done.new(params[:task]).perform
      redirect(root)
    end

    post '/clear' do
      Todo::UseCases::Clear.new.perform
      redirect(root)
    end

    post '/current_day' do
      Todo::UseCases::SetCurrentDay.new(new_day: params["current_day"] || "today").perform
      redirect(root)
    end

    post '/undo' do
      Todo::UseCases::Undo.new.perform
      redirect(root)
    end

    post '/move_up' do
      redirect(root)
    end

    private

    def root
      '/'
    end
  end
end
