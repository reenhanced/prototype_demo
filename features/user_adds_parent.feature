Feature: User adds parent to family card
  In order to add a parent to a family card
  As a user
  I can follow a link from the family card page and fill out a new parent form

  Background:
    Given today is "2012-09-26"
    And I am logged in
    And I have 1 family card
    When I am on the family card's page

  @javascript
  Scenario: User adds parent to a family card they own
    Then the new parent form should be hidden
    When I click "Add family member"
    Then the new parent form should be visible
    When I select "Mother" from "parent_relationship"
    And I fill in the following:
      | parent_first_name | Judy    |
      | parent_last_name  | Garland |
    And I press "Add Family Member"
    Then the parent listing should be visible
    And the family card should have 1 parent
    And I should see the parent's information

  @javascript
  Scenario: User adds a parent to a family card and uses the default parent's address
    When I click "Add family member"
    Then the family card's parent fields should not be disabled
    When I check "Same as family card"
    Then the family card's parent fields should be filled in
    And the family card's parent fields should be disabled
    When I uncheck "Same as family card"
    Then the family card's parent fields should not be filled in
    And the family card's parent fields should not be disabled
    When I check "Same as family card"
    And I press "Add Family Member"
    Then I should see the parent's information with the default parent's contact info

  Scenario: User tries to add a parent to a family card they don't own
    Given I am logged in as "jimmy.buffet@example.com"
    And I have 1 family card
    When I am on another user's family card page
    Then I should not see "#new_parent"
    And I should not see "Add Family Member"
