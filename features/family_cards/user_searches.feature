Feature: Search for card
  To view a family's detailed information
  A signed in user
  Should be able to search for a parent or student

  Background:
    Given I am logged in
    And I have 3 family cards
    And I am on the search family cards page
    Then I should see "Prospect Search"

  Scenario: User searches for a family card
    When I fill in the form with an existing parent's name
    And I press "Search Prospect Records"
    Then I should see the family card
    When I follow the parent's name
    Then I should be on the family card's page

  Scenario: User searches for a family card with empty optional data
    Given I have 1 incomplete family card
    And I fill in the form with an existing parent's name
    And I press "Search Prospect Records"
    Then I should see the parent's name

  Scenario: No family cards are found
    When I press "Search Prospect Records"
    Then I should see "No prospects were found."
    When I follow "Try another search?"
    Then I should see "Prospect Search"
    And I should not see the parent's name
