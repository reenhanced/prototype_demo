Feature: Admin manages users

  Background:
    Given the following users exist:
      | name        | email                   |
      | Carlos Slim | carlos.slim@example.com |
      | Paul Revere | paul.revere@example.com |
    And I am logged in as an admin
    And I am on the admin users page

  Scenario: Users are unauthorized
    Given I am not logged in
    And I exist as a user
    When I sign in with valid credentials
    And I go to the admin users page
    Then I should be redirected to the homepage
    And I should see "Unauthorized Access"

  Scenario: Admin should see link to admin users in nav bar
    Then I should see a link to the admin users page with text "Users" within the top navigation bar

  Scenario: See list of users
    Then I should see the following table rows:
      | Name        | Email                   | Roles | Created | Actions |
      | Carlos Slim | carlos.slim@example.com |       | *       |         |
      | Paul Revere | paul.revere@example.com |       | *       |         |
