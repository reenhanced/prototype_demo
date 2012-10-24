Feature: User edits family member
  As a user
  In order to modify an existing family card's family member
  I can follow a link from the family card page and update the family member details

  Background:
    Given I am logged in
    And I have 1 family card

  @javascript
  Scenario: User edits own family card's family member
    When I am on the family card's page
    And I click "Add family member"
    And I select "Mother" from "family_member_relationship"
    And I fill in the following:
      | family_member_first_name | Sandy                     |
      | family_member_last_name  | Bridge                    |
      | family_member_phone      | (911) 555-1212            |
      | family_member_email      | sandy.bridges@example.com |
      | family_member_address1   | 123 Easy St               |
      | family_member_address2   | Apt. 2                    |
      | family_member_city       | Los Angelos               |
      | family_member_zip_code   | 90210                     |
    And I press "Create Family Member"
    And I press "edit family member"
    And I select "Father" from "family_member_relationship"
    And I fill in the following:
      | family_member_first_name | Jeff |
      | family_member_last_name  | Bridges                   |
      | family_member_phone      | (912) 555-1212            |
      | family_member_email      | jeff.bridges@example.com  |
      | family_member_address1   | 1234 Easy St              |
      | family_member_address2   | Apt. 3                    |
      | family_member_city       | L.A.                      |
      | family_member_zip_code   | 90211                     |
    And I press "Update Family Member"
    Then I should see the following table rows:
      | Relationship | First Name | Last Name | Email                    | Phone          | Address                         |
      | Father       | Jeff       | Bridges   | jeff.bridges@example.com | (912) 555-1212 | *1234 Easy St*Apt. 3*L.A.*90211 |

  Scenario: User tries to edit a family card's family member they don't own
    Given I am logged in as "jimmy.buffet@example.com"
    And I have 1 family card
    When I am on another user's family card page
    Then the new family member form element should not have rendered
    And I should not see "Edit Family Member"
