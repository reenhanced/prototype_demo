Feature: User creates a new family card
  In order to create a new family card record
  As a user
  I can follow a link from the search results and fill out a new record form

  Scenario: User follows create new record from search results
    Given I am logged in
    And I am on the search family cards page
    When I press "Search Prospect Records"
    Then I should see "Create new record"
