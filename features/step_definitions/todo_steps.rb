require 'todo'

Given(/^My todo list contains "([^"]*)"$/) do |todo|
  Todo::UseCases::CreateTodo.new(todo).perform
end