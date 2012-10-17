@javascript
Feature: Admin searches
  To view a family's detailed information
  A signed in admin
  Should be able to search for a parent or student

  Background:
    Given there are 2 family cards
    And I am logged in as an admin

  Scenario: No cards are returned when all search fields are blank
    When I press "Search Prospect Records"
    Then I should see "No prospects were found"

  Scenario: Search results contain 'show' links
    When I press "View All Records"
    Then the parent's name should be a link

  Scenario: "View all Cards" button
    When I press "View All Records"
    Then I should see all the family cards
