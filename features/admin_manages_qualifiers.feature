Feature: Admin manages qualifiers

  Background:
    Given the following qualifiers exist:
      | name                  | position |
      | Uses Pull Requests    | 1        |
      | Doesn't repeat code   | 2        |
      | Writes tests first    | 3        |
      | Tracks completed work | 4        |
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
    And I fill in "Name" with "Cowboy coding"
    And I select "Negative" from "Category"
    And I press "Save"
    Then I should be on the admin qualifiers page
    And I should see "Cowboy coding"

  Scenario: See errors when invalid
    When I click "New Qualifier"
    And I press "Save"
    Then I should see "Name can't be blank"
    And I should see "Category is not included in the list"

  Scenario: See list of qualifiers
    Then I should see the qualifiers in the following order:
      | Uses Pull Requests    |
      | Doesn't repeat code   |
      | Writes tests first    |
      | Tracks completed work |

  @javascript
  Scenario: Drag and drop to reorder
    When I drag qualifier "Tracks completed work" to the top of the list
    And I reload the page
    Then I should see the qualifiers in the following order:
      | Tracks completed work |
      | Uses Pull Requests    |
      | Doesn't repeat code   |
      | Writes tests first    |

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
