Feature: Admin views an audit trail for a family card
  In order to see a complete history of a family card
  As an admin
  I can access an audit log from a family card page

  Scenario: Admin views the audit trail for a new family card
    Given the time is "21 Feb 2013 01:00PM"
    And I am logged in as the admin "admin@example.com"
    When I am on the new family card page
    And I fill in the following:
      | Parent/Guardian First Name  | Gordon                   |
      | Parent/Guardian Last Name   | Ramsy                    |
      | Parent/Guardian Phone       | 123-456-7890             |
      | Parent/Guardian Email       | gordon.ramsy@example.com |
      | family_card_parent_address1 | 1234 Easy St.            |
      | family_card_parent_address2 | Apt. 1                   |
      | family_card_parent_city     | Los Angelos              |
      | family_card_parent_zip_code | 90210                    |
    And I press "Create Family Card"
    And I follow "Show audit trail"
    Then I should see "Family of: Gordon Ramsy"
    And I should see "Back to family card"
    And I should see the following table rows:
      | admin@example.com*@*02:00PM on 02/21/2013* | *Updated Family Card*Gordon Ramsy* | *more details* |
      | admin@example.com*@*02:00PM on 02/21/2013* | *Created Family Card*Gordon Ramsy* | *more details* |
    And I should see the following table rows:
      | Changed    | From | To                       |
      | first_name |      | Gordon                   |
      | last_name  |      | Ramsy                    |
      | phone      |      | 123-456-7890             |
      | email      |      | gordon.ramsy@example.com |
      | address1   |      | 1234 Easy St.            |
      | address2   |      | Apt. 1                   |
      | city       |      | Los Angelos              |
      | zip_code   |      | 90210                    |

  Scenario: Admin views the audit trail for an updated family card
    Given the time is "22 Mar 2013 02:00PM"
    And I am logged in
    And I have 1 family card with parent "Gordon Ramsy"
    When I am on the family card's page
    And I follow "Edit Family Card"
    And I fill in the following:
      | Parent/Guardian First Name  | Ramsy                         |
      | Parent/Guardian Last Name   | Cornerstone                   |
      | Parent/Guardian Phone       | 911.555.1212                  |
      | Parent/Guardian Email       | ramsy.cornerstone@example.com |
      | family_card_parent_address1 | 1234 Heaven Hwy.              |
      | family_card_parent_address2 | Suite 10000                   |
      | family_card_parent_city     | New York                      |
      | family_card_parent_zip_code | 10010                         |
    And I press "Update Family Card"
    And I follow "Show audit trail"
    And I should see the following table rows:
      | admin@example.com*@*03:00PM on 03/22/2013* | *Updated Family Member*Ramsy Cornerstone* | *more details* |
    And I should see the following table rows:
      | Changed    | From                     | To                            |
      | first_name | Gordon                   | Ramsy                         |
      | last_name  | Ramsy                    | Cornerstone                   |
      | phone      | 123-456-7890             | 911.555.1212                  |
      | email      | gordon.ramsy@example.com | ramsy.cornerstone@example.com |
      | address1   | 1234 Easy St.            | 1234 Heaven Hwy.              |
      | address2   | Apt. 1                   | Suite 10000                   |
      | city       | Los Angelos              | New York                      |
      | zip_code   | 90210                    | 10010                         |

  Scenario: A non-admin user tries to view a family card's audit trail
    Given I am logged in
    And I have 1 family card
    When I am on the family card's page
    Then I should not see "Show audit trail"
