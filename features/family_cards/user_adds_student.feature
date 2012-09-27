Feature: User adds student to family card
  In order to add a student to a family card
  As a user
  I can follow a link from the family card page and fill out a new student form

  @javascript
  Scenario: User adds student
    Given today is "2012-09-26"
    And I am logged in
    And I have 1 family card
    And I am on the family card's page
    Then "#new-student" should be hidden
    When I click "Add student"
    Then "#new-student" should be visible
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
    And I wait for the ajax to finish
    Then "#all-students" should be visible
    And the family card should have 1 student
    And I should see the student's information
