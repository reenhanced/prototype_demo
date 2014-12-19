Feature: User adds call log to family card
  In order to add a call log to a family card
  As a user
  I can follow a link from the family card page and fill out a call log form

  Background:
    Given the following qualifiers exist:
      | name   | position |
      | First  | 1        |
      | Third  | 3        |
      | Second | 2        |
    And I am logged in
    And today is "21 Feb 2013" at "1:00pm"
    And I have 1 call log

  @javascript
  Scenario: User adds a call log to one of their family cards
    When I am on the family card's page
    And I click "Add call log"
    Then the new call log form should be visible within the popup modal
    And I should see "Spoke to"
    When I select the first member from the new call log contacts
    Then the "call_log_contact_type" hidden field should contain "FamilyMember"
    When I check the first qualifier
    And I fill in "call_log_message" with "I am batman."
    And I press "Save Entry"
    Then the new call log form should be hidden
    And the call log listing should be visible
    And I should see the call's information
    And the call should have recorded the date and time
    And the family card should have the selected qualifier
    And the selected qualifier should be checked
    And I should see "First" within the family card's qualifiers
    When I click "Add call log"
    Then the new call log form should be visible within the popup modal
    When I select the first member from the new call log contacts
    And I fill in "call_log_message" with "Removing a qualifier"
    And I uncheck the first qualifier
    And I press "Save Entry"
    Then the family card should not have the selected qualifier
    And the selected qualifier should not be checked
    And I should not see "First" within the family card's qualifiers

  @javascript
  Scenario: User sees qualifiers listed in order
    When I am on the family card's page
    And I click "Add call log"
    Then I should see qualifier checkboxes in the following order within the popup modal:
      | First  |
      | Second |
      | Third  |

  @javascript
  Scenario: User changes the recorded date or time of the call log
    When I am on the family card's page
    And I click "Add call log"
    Then the new call log form should be visible within the popup modal
    And I should see the date and time today within the new call log form
    And I should see "Edit" within the new call log form
    When I press "Edit" within the new call log form
    And I select "22nd Mar 2013 01:00:00 PM" as the "Call recorded at" date and time
    Then I should see "1:00PM on 3/22/2013" within the new call log form
    When I select the first member from the new call log contacts
    And I fill in "call_log_message" with "I am batman."
    And I press "Save Entry"
    Then the new call log form should be hidden
    And the call log listing should be visible
    And I should see the call's information

  @javascript
  Scenario: User attempts to add a call log without a message to one of their family cards
    When I am on the family card's page
    And I click "Add call log"
    And I press "Save Entry"
    Then I should see "Message can't be blank"

  @javascript
  Scenario: User tries to add student to a family card they don't own
    Given I am logged in as "jimmy.buffet@example.com"
    And I have 1 family card
    When I am on another user's family card page
    Then I should not see "Add call log"
