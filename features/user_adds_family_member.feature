Feature: User adds family member to family card
  In order to add a family member to a family card
  As a user
  I can follow a link from the family card page and fill out a new family member form

  Background:
    Given today is "2012-09-26"
    And I am logged in
    And I have 1 family card
    When I am on the family card's page

  @javascript
  Scenario: User adds family member to a family card they own
    Then the new family member form should be hidden
    When I click "Add family member"
    Then the new family member form should be visible
    When I select "Mother" from "family_member_relationship"
    And I fill in the following:
      | family_member_first_name | Judy                    |
      | family_member_last_name  | Garland                 |
      | family_member_phone      | (911) 555-1212          |
      | family_member_email      | bobby.jones@example.com |
      | family_member_address1   | 123 Easy St             |
      | family_member_address2   | Apt. 2                  |
      | family_member_city       | Los Angelos             |
      | family_member_zip_code   | 90210                   |
    And I press "Create Family Member"
    Then the family member listing should be visible
    And the family card should have 2 family members
    And I should see the family member's information

  @javascript
  Scenario: User adds a family member to a family card and uses the default family member's address
    When I click "Add family member"
    Then the family card's family member fields should not be disabled
    When I check "Same as family card"
    Then the family card's family member fields should be filled in
    And the "Same as family card" checkbox should be checked
    And the family card's family member fields should be disabled
    When I uncheck "Same as family card"
    Then the family card's family member fields should not be filled in
    And the family card's family member fields should not be disabled
    When I check "Same as family card"
    And I press "Create Family Member"
    Then I should see the family member's information with the default family member's contact info

  Scenario: User tries to add a family member to a family card they don't own
    Given I am logged in as "jimmy.buffet@example.com"
    And I have 1 family card
    When I am on another user's family card page
    Then the new family member form element should not have rendered
    And I should not see "Add Family Member"
