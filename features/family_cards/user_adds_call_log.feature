Feature: User adds call log to family card
  In order to add a call log to a family card
  As a user
  I can follow a link from the family card page and fill out a call log form

  Background:
    Given I am logged in
    And I have 2 family cards
    And I have initial qualifiers
    And today is "21 Feb 2013" at "1:00pm"

  @javascript
  Scenario: User adds a call log to one of their family cards
    When I am on the family card's page
    Then I should see "Add call log"
    And I should see "All Calls"
    And "#new-call" should be collapsed
    And "#all-calls" should be hidden
    When I click "Add call log"
    Then "#new-call" should be visible
    And I should see "Spoke to"
    And I should see the date and time today within "the new call log form"
    And I should see "edit" within "#new-call"
    When I fill in "call_log_message" with "I am batman."
    And I select the first member from "#call_log_contact_id"
    Then the "call_log_contact_type" hidden field should contain "Parent"
    When I check the first qualifier
    And I press "Save Entry"
    And I wait for the ajax to finish
    Then I should see "Successfully added call log."
    And "#new-call" should be collapsed
    And "#all-calls" should be visible
    And I should see the call's information
    And the family card should have the selected qualifier
    When I am on the family card's page
    Then the selected qualifier should be checked

  @javascript
  Scenario: User attempts to add a call log without a message to one of their family cards
    When I am on the family card's page
    And I click "Add call log"
    And I press "Save Entry"
    And I wait for the ajax to finish
    Then I should see "Message can't be blank"

  @javascript
  Scenario: User tries to add student to a family card they don't own
    Given I am logged in as "jimmy.buffet@example.com"
    And I have 1 family card
    When I am on another user's family card page
    Then I should not see "Add call log"
