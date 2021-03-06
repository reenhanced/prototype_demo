Feature: User adds student to family card
  In order to add a student to a family card
  As a user
  I can follow a link from the family card page and fill out a new student form

  Background:
    Given today is "2012-09-26"
    And I am logged in
    And I have 1 family card
    When I am on the family card's page

  @javascript
  Scenario: User adds student to a family card they own
    Then the new student form should be hidden
    When I click "Add student"
    Then the new student form should be visible
    And I select "1994-02-21" as the "Birthday" date
    And I select "2012" from "student_graduation_year"
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
    Then the student listing should be visible
    And the family card should have 1 student
    And I should see the student's information
    And the family card's default student should be "Bobby Jones"

  @javascript
  Scenario: User adds student to a family card and uses the default parent's address
    When I click "Add student"
    And I click "Copy from family card"
    Then the family card's student fields should be filled in
    When I press "Create Student"
    Then I should see the student's information with the default parent's contact info

  @javascript
  Scenario: User adds student to a family card and makes it the default student
    Given the family card has a default student "Prudice Johnson"
    When I click "Add student"
    And I click "Copy from family card"
    And I check "Make default student" within the new student form
    And I fill in the following:
      | student_first_name | Annoxa |
      | student_last_name  | Jones  |
    When I press "Create Student"
    Then I should see the student's information
    And the family card's default student should be "Annoxa Jones"

  @javascript
  Scenario: User changes default student
    Given the family card has a default student "Tom Brady"
    When I click "Add student"
    And I click "Copy from family card"
    And I fill in the following:
      | student_first_name | Praximus |
      | student_last_name  | Jones    |
    When I press "Create Student"
    Then I should see the student's information
    And the family card's default student should be "Tom Brady"
    When I press "edit student" within the student row
    And I check "Make default student" within the edit student row
    And I press "Save Student" within the edit student row
    Then the family card's default student should be "Praximus Jones"

  Scenario: User tries to add student to a family card they don't own
    Given I am logged in as "jimmy.buffet@example.com"
    And I have 1 family card
    When I am on another user's family card page
    Then I should not see "#new_student"
    And I should not see "Add student"
