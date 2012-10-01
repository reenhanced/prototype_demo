Feature: User adds call log to family card
  In order to add a call log to a family card
  As a user
  I can follow a link from the family card page and fill out a call log form

  Background:
    Given I am logged in
    And I have 1 family card

  @javascript
  Scenario: User adds a call log to one of their family cards
    When I am on the family card's page
    Then I should see "Add call log"

  Scenario: User tries to add student to a family card they don't own
    Given I am logged in as "jimmy.buffet@example.com"
    And I have 1 family card
    When I am on another user's family card page
    Then I should not see "Add call log"
