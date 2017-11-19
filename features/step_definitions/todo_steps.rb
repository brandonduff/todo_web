require 'todo'

Given(/^My todo list contains "([^"]*)"$/) do |todo|
  Todo::UseCases::SetCurrentDay.new(new_day: 'today').perform
  Todo::UseCases::CreateTodo.new(todo).perform
end