Feature: Web Todos App
  Scenario: I can see existing todos
    Given My todo list contains "existing todo"
    When I go to the home page
    Then I should see "existing todo"

  Scenario: I can add a new todo
    Given I am on the home page
    When I fill in "New Todo" with "foo"
    And I press "Create"
    Then I should see "foo"

  Scenario: I can delete an existing todo
    Given My todo list contains "existing todo"
    And I am on the home page
    When I delete "existing todo"
    Then I should not see "existing todo"
