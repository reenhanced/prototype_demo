@javascript
Feature: Admin searches
  To view a family's detailed information
  A signed in admin
  Should be able to search for a parent or student

  Background:
    Given I exist as an admin
    And I have 2 family cards
    And I sign in with valid credentials

  Scenario: All cards shown when search fields are left blank
    When I press "Search Prospect Records"
    Then I should see all the family cards
