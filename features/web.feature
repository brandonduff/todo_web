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
    When I press "Done"
    Then I should see the done todo "existing todo"

  Scenario: I can clear done todos
    Given My todo list contains the done todo "done todo"
    And My todo list contains "in progress todo"
    And I am on the home page
    When I press "Clear"
    Then I should see "in progress todo"
    And I should not see "done todo"
