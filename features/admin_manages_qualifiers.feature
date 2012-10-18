Feature: Admin manages qualifiers

  Background:
    Given the following qualifiers exist:
      | name                |
      | Uses Pull Requests  |
      | Doesn't repeat code |
    And I am logged in as an admin
    And I am on the admin qualifiers page

  Scenario: Users are unauthorized
    Given I am not logged in
    And I exist as a user
    When I sign in with valid credentials
    And I go to the admin qualifiers page
    Then I should be redirected to the homepage
    And I should see "Unauthorized Access"

  Scenario: Admin should see link to admin qualifiers in nav bar
    Then I should see a link to the admin qualifiers page with text "Qualifiers" within the top navigation bar

  Scenario: Create new qualifier
    When I click "New Qualifier"
    And I fill in "Name" with "Writes tests first"
    And I press "Save"
    Then I should be on the admin qualifiers page
    And I should see "Writes tests first"

  Scenario: See list of qualifiers
    Then I should see "Uses Pull Requests"
    And I should see "Doesn't repeat code"

  Scenario: Edit qualifier
    When I click the edit link for the "Uses Pull Requests" qualifier
    And I fill in "Name" with "Uses Pull Requests always"
    And I press "Save"
    Then I should be on the admin qualifiers page
    And I should see "Uses Pull Requests always"

  Scenario: Delete qualifier
    When I delete the "Uses Pull Requests" qualifier
    Then I should be on the admin qualifiers page
    And I should not see "Uses Pull Requests"
