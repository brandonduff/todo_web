require "todo_web/version"
require 'sinatra/base'
require 'todo'

module TodoWeb
  class App < Sinatra::Base
    get '/' do
      MainView.new(todos: Todo::UseCases::ListTodos.new(presenter: TodoPresenter.new, all: true).perform,
                   current_day: Date.parse(Todo::UseCases::SetCurrentDay.new({}).perform)).render(continuation_dictionary: continuation_dictionary)
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
      Todo::UseCases::Clear.perform
      redirect(root)
    end

    post '/current_day' do
      Todo::UseCases::SetCurrentDay.new(new_day: params["current_day"] || "today").perform
      redirect(root)
    end

    post '/undo' do
      Todo::UseCases::Undo.perform
      redirect(root)
    end

    post '/move_up' do
      Todo::UseCases::Move.perform(params['todo'], :up)
      redirect(root)
    end

    post '/move_down' do
      Todo::UseCases::Move.perform(params['todo'], :down)
      redirect(root)
    end

    post '/:action' do
      continuation_dictionary[params['action']].call
      redirect(root)
    end

    private

    def self.continuation_dictionary
      @continuation_dictionary ||= ContinuationDictionary.new
    end

    def continuation_dictionary
      self.class.continuation_dictionary
    end

    def root
      '/'
    end
  end
end
