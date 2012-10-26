Feature: User views call log details
  In order to veiw a call log's details
  As a user
  I can click a "more details" link in the call log listing

  @javascript
  Scenario: User views more details of a call log
    Given I am logged in
    And I have 1 call log
    And the call log has qualifiers
    When I am on the family card's page
    And I click "All Calls"
    And I click "more details"
    Then I should see the call log details within the popup modal

  Scenario: User views a family card's qualifiers
    Given I am logged in
    And I have a call log with the following qualifiers:
      | category | name |
      | positive | Loves chocolate |
      | neutral  | Likes bats      |
      | negative | Loves blood     |
    When I am on the family card's page
    Then I should see "Qualifiers"
    And I should see "Loves chocolate"
    And I should see "Likes bats"
    And I should see "Loves blood"

  Scenario: User tries to view a card he doesn't own
    Given there is 1 family card
    And I am logged in as "someweirdo@example.com"
    When I go to the family card's page
    Then I should be redirected to the home page
    And I should see "You are not authorized" within the alert box
