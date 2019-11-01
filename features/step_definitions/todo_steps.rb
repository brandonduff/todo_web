require 'todo'

Given(/^My todo list contains "([^"]*)"$/) do |todo|
  Todo::UseCases::CreateTodo.new(todo).perform
end

Given(/^My todo list contains the done todo "([^"]*)"$/) do |todo|
  step %(My todo list contains "#{todo}")
  Todo::UseCases::Done.new.perform
end


Given(/^the current day is "([^"]*)"$/) do |day|
  Todo::UseCases::SetCurrentDay.new(new_day: day).perform
end

When('I move up {string}') do |todo|
  pending
  click_button("Move up #{todo}")
end

Then('the first todo is {string}') do |todo|
  assert_includes page.find('li', match: :first).text, todo
end
