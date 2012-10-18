@javascript
Feature: Sign in
  In order to get access to protected sections of the site
  A user
  Should be able to sign in

  Background:
    Given I exist as a user
    And I am not logged in

  Scenario: User is not signed up
    Given I do not exist as a user
    When I sign in with valid credentials
    Then I see an invalid login message
    And I should be signed out

  Scenario: User signs in successfully
    When I sign in with valid credentials
    Then I see a successful sign in message
    When I return to the site
    Then I should be signed in

  Scenario: User enters wrong email
    When I sign in with a wrong email
    Then I see an invalid login message
    And I should be signed out

  Scenario: User enters wrong password
    When I sign in with a wrong password
    Then I see an invalid login message
    And I should be signed out

  Scenario: User sees top navigation bar
    When I sign in with valid credentials
    Then I should see my email within the top navigation bar
    And I should see a link to the new search page with text "Search" within the top navigation bar
    But I should not see "Admin" within the top navigation bar
