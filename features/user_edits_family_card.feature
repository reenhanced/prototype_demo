Feature: User edits a family card
  In order to change the family card details
  As a user
  I can fill out a form with changes for the default parent and update the family card

  Background:
    Given I am logged in
    And I have 1 family card

  Scenario: User edits a family card
    When I am on the family card's page
    And I follow "Edit Family Card"
    And I fill in the following:
      | Parent/Guardian First Name  | George                       |
      | Parent/Guardian Last Name   | Masterson                    |
      | Parent/Guardian Phone       | 911.555.1212                 |
      | Parent/Guardian Email       | george.masterson@example.com |
      | family_card_parent_address1 | 1234 Heaven Hwy.             |
      | family_card_parent_address2 | Suite 10000                  |
      | family_card_parent_city     | New York                     |
      | family_card_parent_zip_code | 10010                        |
    And I press "Update Family Card"
    Then I should see "Family of: George Masterson"
    And I should see the detailed family card

  Scenario: User cancels the editing of a family card
    When I am on the family card's page
    And I follow "Edit Family Card"
    And I follow "Cancel"
    Then I should be on the family card's page

  Scenario: User tries to edit a family card they don't own
    Given I am logged in as "jimmy.buffet@example.com"
    And I have 1 family card
    When I am on another user's family card page
    Then I should not see "Edit Family Card"

  Scenario: Admin edits a family card
    Given I am logged in as the admin "jimmy.buffet@example.com"
    When I am on another user's family card page
    And I follow "Edit Family Card"
    And I fill in the following:
      | Parent/Guardian First Name  | George                       |
      | Parent/Guardian Last Name   | Masterson                    |
      | Parent/Guardian Phone       | 911.555.1212                 |
      | Parent/Guardian Email       | george.masterson@example.com |
      | family_card_parent_address1 | 1234 Heaven Hwy.             |
      | family_card_parent_address2 | Suite 10000                  |
      | family_card_parent_city     | New York                     |
      | family_card_parent_zip_code | 10010                        |
    And I press "Update Family Card"
    Then I should see "Family of: George Masterson"
    And I should see the detailed family card
