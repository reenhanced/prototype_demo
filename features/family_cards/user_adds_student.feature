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
    When I select "Prospective Student" from "student_relationship"
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

  @javascript
  Scenario: User adds student to a family card and uses the default parent's address
    When I click "Add student"
    Then the family card's student fields should not be disabled
    When I check "Same as family card"
    Then the family card's student fields should be filled in
    And the family card's student fields should be disabled
    When I uncheck "Same as family card"
    Then the family card's student fields should not be filled in
    And the family card's student fields should not be disabled
    When I check "Same as family card"
    And I press "Create Student"
    Then I should see the student's information with the default parent's contact info

  Scenario: User tries to add student to a family card they don't own
    Given I am logged in as "jimmy.buffet@example.com"
    And I have 1 family card
    When I am on another user's family card page
    Then I should not see "#new_student"
    And I should not see "Add student"
