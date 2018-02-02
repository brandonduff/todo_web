require 'todo'

Given(/^My todo list contains "([^"]*)"$/) do |todo|
  Todo::UseCases::CreateTodo.new(todo).perform
end

Given(/^My todo list contains the done todo "([^"]*)"$/) do |todo|
  step %(My todo list contains "#{todo}")
  Todo::UseCases::Done.new.perform
end
