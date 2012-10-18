Feature: Admin views an audit trail for a family card
  In order to see a complete history of a family card
  As an admin
  I can access an audit log from a family card page

  Background:
    Given the time is "22 Mar 2013 02:00PM"
    And I am logged in as the admin "admin@example.com"

  Scenario: Admin views the audit trail for a new family card
    Given the time is "21 Feb 2013 01:00PM"
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
      | Changed     | From | To                       |
      | user        |      | admin@example.com        |
      | family card |      | Gordon Ramsy             |
      | first name  |      | Gordon                   |
      | last name   |      | Ramsy                    |
      | address1    |      | 1234 Easy St.            |
      | address2    |      | Apt. 1                   |
      | city        |      | Los Angelos              |
      | zip code    |      | 90210                    |
      | phone       |      | 123-456-7890             |
      | email       |      | gordon.ramsy@example.com |

  Scenario: Admin views the audit trail for an updated family card
    Given I have a family card with parent "Gordon Ramsy"
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
    Then I should see the following table rows:
      | admin@example.com*@*03:00PM on 03/22/2013* | *Updated Family Member*Ramsy Cornerstone* | *more details* |
    And I should see the audit changes for the updated family card's default parent:
      | first_name | Ramsy                         |
      | last_name  | Cornerstone                   |
      | phone      | 911.555.1212                  |
      | email      | ramsy.cornerstone@example.com |
      | address1   | 1234 Heaven Hwy.              |
      | address2   | Suite 10000                   |
      | city       | New York                      |
      | zip_code   | 10010                         |

  @javascript
  Scenario: Admin views the audit trail for a new student
    Given I have a family card with parent "Gordon Ramsy"
    When I am on the family card's page
    And I select "Prospective Student" from "student_relationship"
    And I select "1994-02-21" as the "Birthday" date
    And I select "2013" from "student_graduation_year"
    And I select "Male" from "student_gender"
    And I fill in the following:
      | student_first_name | Bobby                   |
      | student_last_name  | Jones                   |
      | student_phone      | (911) 555-1212          |
      | student_email      | bobby.jones@example.com |
      | student_address1   | 123 Easy St             |
      | student_address2   | Apt. 2                  |
      | student_city       | Los Angelos             |
      | student_zip_code   | 90210                   |
    And I press "Create Student"
    And I follow "Show audit trail"
    Then I should see the following table rows:
      | admin@example.com*@*03:00PM on 03/22/2013* | *Created Student*Bobby Jones* | *more details* |
    And I should see the following table rows:
      | Changed    | From | To                      |
      | first name |      | Bobby                   |
      | last name  |      | Jones                   |
      | address    |      | 123 Easy St             |
      | address 2  |      | Apt. 2                  |
      | city       |      | Los Angelos             |
      | zip code   |      | 90210                   |
      | phone      |      | (911) 555-1212          |
      | email      |      | bobby.jones@example.com |

  @javascript
  Scenario: Admin views the audit trail for a new family member
    Given I have a family card with parent "Gordon Ramsy"
    When I am on the family card's page
    And I click "Add family member"
    And I select "Mother" from "family_member_relationship"
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
    And I follow "Show audit trail"
    Then I should see the following table rows:
      | admin@example.com*@*03:00PM on 03/22/2013* | *Created Family Member*Judy Garland* | *more details* |
    And I should see the following table rows:
      | Changed     | From | To                      |
      | family card |      | Gordon Ramsy            |
      | first name  |      | Judy                    |
      | last name   |      | Garland                 |
      | address     |      | 123 Easy St             |
      | address 2   |      | Apt. 2                  |
      | city        |      | Los Angelos             |
      | zip code    |      | 90210                   |
      | phone       |      | (911) 555-1212          |
      | email       |      | bobby.jones@example.com |

  @javascript
  Scenario: Admin views the audit trail for a new call log
    Given I have a family card with parent "Gordon Ramsy"
    And I have 1 qualifier with "Eats bugers."
    When I am on the family card's page
    And I click "Add call log"
    And I select the first member from the new call log contacts
    And I check the first qualifier
    And I fill in "call_log_message" with "I am batman."
    And I press "Save Entry"
    And I follow "Show audit trail"
    Then I should see the following table rows:
      | admin@example.com*@*03:00PM on 03/22/2013* | *Created Call Log*Spoke to: Gordon Ramsy* | *more details* |
      | admin@example.com*@*03:00PM on 03/22/2013* | *Added Family Card Qualifier*"Eats bugers." for Gordon Ramsy* | *more details* |
    And I should see the following table rows:
      | Changed     | From | To                     |
      | family card |      | Gordon Ramsy           |
      | qualifier   |      | [positive] Eats bugers. |
    And I should see the following table rows:
      | Changed          | From | To                    |
      | family card      |      | Gordon Ramsy          |
      | message          |      | I am batman.          |
      | spoke to         |      | Gordon Ramsy          |
      | contact type     |      | FamilyMember          |
      | call recorded at |      | 03:00PM on 03/22/2013 |

  Scenario: A non-admin user tries to view a family card's audit trail
    Given I am logged in
    And I have 1 family card
    When I am on the family card's page
    Then I should not see "Show audit trail"
