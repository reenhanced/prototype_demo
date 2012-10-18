Feature: Admin signs in
  As an admin
  I want to sign in
  So I can use the site

  Background:
    Given I am logged in as an admin

  Scenario: Admin is redirected to the search screen upon login
    Then I should see "Prospect Search"

  Scenario: Admin sees admin dropdown
    Then I should see "Admin" within the top navigation bar
