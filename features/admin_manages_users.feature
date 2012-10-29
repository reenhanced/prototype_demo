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

  Scenario: Create new user
    When I click "New User"
    And I fill in "Name" with "Ross Perot"
    And I fill in "Email" with "ross.perot@example.com"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "password"
    And I check "admin"
    And I press "Create User"
    Then I should be on the admin users page
    And I should see the following table rows:
      | Name       | Email                  | Roles | Created | Actions       |
      | Ross Perot | ross.perot@example.com | admin | *       | *edit*delete* |
    And the "last" user should have the "admin" role

  Scenario: See errors when invalid
    When I click "New User"
    And I press "Create User"
    Then I should see "Email can't be blank"
    And I should see "Password can't be blank"

  Scenario: See list of users
    Then I should see the following table rows:
      | Name        | Email                   | Roles | Created | Actions       |
      | Carlos Slim | carlos.slim@example.com |       | *       | *edit*delete* |
      | Paul Revere | paul.revere@example.com |       | *       | *edit*delete* |

  Scenario: Edit user
    When I click "edit" within the user row
    And I fill in "Name" with "Mr. Goodcat"
    And I fill in "Email" with "mr.goodcat@example.com"
    And I fill in "Password" with "123456"
    And I fill in "Password confirmation" with "123456"
    And I press "Save User"
    Then I should see "User was successfully updated"
    And I should be on the admin users page
    And I should see the following table rows in any order:
      | Name        | Email                  | Roles | Created | Actions       |
      | Mr. Goodcat | mr.goodcat@example.com | *     | *       | *edit*delete* |

  Scenario: Edit user roles
    When I click "edit" within the "Carlos Slim" user row
    Then I should see "Roles"
    When I check "admin"
    And I press "Save User"
    Then I should see "User was successfully updated"
    And I should see the following table rows in any order:
      | Name        | Email                   | Roles | Created | Actions       |
      | Carlos Slim | carlos.slim@example.com | admin | *       | *edit*delete* |
    And the "Carlos Slim" user should have the "admin" role
    When I click "edit" within the "Carlos Slim" user row
    When I uncheck "admin"
    And I press "Save User"
    Then I should see "User was successfully updated"
    And I should see the following table rows in any order:
      | Name        | Email                   | Roles | Created | Actions       |
      | Carlos Slim | carlos.slim@example.com |       | *       | *edit*delete* |
    And the "Carlos Slim" user should not have the "admin" role

  Scenario: Edit user without updating password
    When I click "edit" within the "Carlos Slim" user row
    And I fill in "Name" with "Mr. Goodcat"
    And I fill in "Email" with "mr.goodcat@example.com"
    And I press "Save User"
    Then I should see "User was successfully updated"
    And I should be on the admin users page
    And I should see the following table rows in any order:
      | Name        | Email                  | Roles | Created | Actions       |
      | Mr. Goodcat | mr.goodcat@example.com | *     | *       | *edit*delete* |

  @javascript
  Scenario: Delete user
    When I click "delete" within the first user row
    Then I should be on the admin users page
    And I should not see the following table rows:
      | Carlos Slim | carlos.slim@example.com | | * | *edit*delete* |
