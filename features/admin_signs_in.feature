Feature: Admin signs in
  As an admin
  I want to sign in
  So I can use the site

  Scenario: Admin is redirected to the search screen upon login
    Given I exist as an admin
    When I sign in with valid credentials
    Then I should be on the search screen
