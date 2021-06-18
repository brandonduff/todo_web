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

  Scenario: I can clear done todos
    Given My todo list contains the done todo "done todo"
    And My todo list contains "in progress todo"
    And I am on the home page
    When I press "Clear"
    Then I should see "in progress todo"
    And I should not see "done todo"

  Scenario: I can see the current day
    Given the current day is "1/1/2000"
    When I am on the home page
    Then the "Current Day" field should contain "2000-01-01"

  Scenario: I can set the current day
    Given the current day is "1/1/2000"
    And I am on the home page
    When I fill in "Current Day" with "1993-10-03"
    And press "Change Date"
    And I go to the home page
    Then the "Current Day" field should contain "1993-10-03"

  Scenario: I can set the current day to today
    Given the current day is "1/1/2000"
    And I am on the home page
    When I press "Today"
    Then the "Current Day" field should show today

  Scenario: I can undo a done todo
    Given My todo list contains the done todo "done todo"
    And I am on the home page
    When I press "Undo"
    Then I should see the undone todo "done todo"

  Scenario: I can rearrange the order of todos
    Given My todo list contains "first todo"
    And My todo list contains "second todo"
    When I am on the home page
    And I move up "second todo"
    Then the first todo is "second todo"
    And I move down "second todo"
    Then the first todo is "first todo"
