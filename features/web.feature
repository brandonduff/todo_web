Feature: Web Todos App
  Scenario: I can see existing todos
    Given My todo list contains "existing todo"
    When I go to the home page
    Then I should see "existing todo"

  Scenario: I can add a new todo
    Given I go to the home page
    When I fill in "New Todo" with "foo"
    And I press "Create"
    Then I should see "foo"
