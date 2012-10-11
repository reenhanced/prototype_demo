Feature: Admins can see the full changelog for a family card
  In order to see changes to history cards over time
  As an admin
  I can see the history of all changes in a log

  Scenario: User sees details of family log being created
    Given I am logged in
    And I am on the new family card page
    When I fill in the following:
      | Parent/Guardian First Name  | Dolly                   |
      | Parent/Guardian Last Name   | Parton                  |
      | Phone                       | (911) 555-1212          |
      | family_card_parent_email    | dollyparton@example.com |
      | family_card_parent_address1 | 123 Easy St             |
      | family_card_parent_address2 | Apt. 2                  |
      | family_card_parent_city     | Los Angelos             |
      | family_card_parent_zip_code | 90210                   |
    And I select "California" from "family_card_parent_state"
    And I press "Create Family Card"
    And I click "See History"
    Then I should see "Family Card created by test@example.com"
    And I should see "Parent/Guardian First Name changed from nil to Dolly"
    And I should see "Parent/Guardian Last Name changed from nil to Parton"
    And I should see "Phone changed from nil to (911) 555-1212"
    And I should see "Phone changed from nil to (911) 555-1212"
