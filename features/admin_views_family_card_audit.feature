Feature: Admin views an audit trail for a family card
  In order to see a complete history of a family card
  As an admin
  I can access an audit log from a family card page

  Scenario: Admin views a family card's audit trail
    Given I am logged in as an admin
    And I have 1 family card
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
    And I follow "Show audit trail"
    Then I should see "Family of: George Masterson"
    And I should see "Back to family card"
    And I should see the family card audit trail

  Scenario: A non-admin user tries to view a family card's audit trail
    Given I am logged in
    And I have 1 family card
    When I am on the family card's page
    Then I should not see "Show audit trail"
