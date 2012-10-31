Feature: User edits student
  As a user
  In order to modify an existing family card's student
  I can follow a link from the family card page and update the student details

  Background:
    Given today is "2012-09-26"
    And I am logged in
    And I have 1 family card
    And I have 1 student

  @javascript
  Scenario: User edits own family card's student
    When I am on the family card's page
    Then the edit student row should be collapsed
    When I press "edit student" within the student row
    Then the edit student row should be expanded
    When I select "1995-03-22" as the "Birthday" date
    And I select "2013" from "student_graduation_year"
    And I select "Female" from "student_gender"
    And I fill in the following within the edit student row:
      | student_first_name | Donny                    |
      | student_last_name  | Brasco                   |
      | student_phone      | (900) 911-1212           |
      | student_email      | donny.brasco@example.com |
      | student_address1   | 321 Easy St              |
      | student_address2   | Apt. 3                   |
      | student_city       | L.A.                     |
      | student_zip_code   | 90211                    |
    And I select "California" from "student_state"
    And I press "Save Student" within the edit student row
    Then the edit student row should be collapsed
    And I should see the following table rows:
      | First Name | Last Name | Email                    | Phone          | Address                      |
      | Donny      | Brasco    | donny.brasco@example.com | (900) 911-1212 | *321 Easy St*Apt. 3*CA*90211 |

  @javascript
  Scenario: User cancels editting of a student
    Given I have 1 student
    When I am on the family card's page
    And I click "All students"
    Then the edit student row should be collapsed
    When I press "edit student"
    Then the edit student row should be expanded
    And I follow "Cancel" within the edit student row
    Then the edit student row should be collapsed

  Scenario: User tries to edit a family card's student they don't own
    Given I am logged in as "jimmy.buffet@example.com"
    And I have 1 family card
    When I am on another user's family card page
    Then the edit student row element should not have rendered
    And I should not see "edit student"
