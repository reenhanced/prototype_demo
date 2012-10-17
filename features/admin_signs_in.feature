Feature: Admin signs in
  As an admin
  I want to sign in
  So I can use the site

  @javascript
  Scenario: Admin is redirected to the search screen upon login
    Given I exist as an admin
    When I sign in with valid credentials
    Then I should see "Prospect Search"
