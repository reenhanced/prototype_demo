Feature: Admin signs in
  As an admin
  I want to sign in
  So I can use the site

  Background:
    Given I exist as an admin
    When I sign in with valid credentials

  @javascript
  Scenario: Admin is redirected to the search screen upon login
    Then I should be on the search screen

  Scenario: Admin sees admin dropdown
    Then I should see "Admin" within the top navigation bar

