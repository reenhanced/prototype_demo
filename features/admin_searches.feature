@javascript
Feature: Admin searches
  To view a family's detailed information
  A signed in admin
  Should be able to search for a parent or student

  Background:
    Given I exist as an admin
    And I have 2 family cards
    And I sign in with valid credentials

  Scenario: No cards are returned when all search fields are blank
    When I press "Search Prospect Records"
    Then I should see "No prospects were found"

  Scenario: "View all Cards" button
    When I press "View All Records"
    Then I should see all the family cards
