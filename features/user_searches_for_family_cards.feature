@javascript
Feature: Search for card
  To view a family's detailed information
  A signed in user
  Should be able to search for a parent or student

  Background:
    Given I am logged in
    And I have 2 family cards
    And I have a family card with parent "Thor Hammerstein"
    And I am on the search family cards page

  Scenario: Users see a search button but not the "all records" button
    Then the prospect search button should have rendered
    But the view all button should not have rendered

  Scenario: User searches for a family card
    When I fill in the form with an existing parent's name
    And I press "Search Prospect Records"
    Then I should see the family card
    And I should see "Edit Family Card"
    But I should not see "Add Student"
    When I follow the parent's name
    Then I should be on the family card's page
    And I should see the detailed family card

  Scenario: User searches for a family card with empty optional data
    Given I have 1 incomplete family card
    And I fill in the form with an existing parent's name
    And I press "Search Prospect Records"
    Then I should see the parent's name

  Scenario: User searches for a family card with loose matching terms
    When I fill in "family_member_first_name" with "thor"
    And I fill in "family_member_last_name" with "hammerstein"
    And I press "Search Prospect Records"
    Then I should see the parent's name
    Given I am on the search family cards page
    When I fill in "family_member_first_name" with "Tho"
    And I fill in "family_member_last_name" with "Ham"
    And I press "Search Prospect Records"
    Then I should see the parent's name
    Given I am on the search family cards page
    When I fill in "family_member_first_name" with "tho"
    And I fill in "family_member_last_name" with "ham"
    And I press "Search Prospect Records"
    Then I should see the parent's name

  Scenario: User searches for and finds a family card they don't own
    Given I am logged in as "jimmy.buffet@example.com"
    And I am on the search family cards page
    When I fill in the form with an existing parent's name
    And I press "Search Prospect Records"
    Then I should see the family card
    But I should not see "Edit Family Card"
    And I should not see a link to the family card's page with text "Thor Hammerstein"

  Scenario: Search results are automatically populated via ajax
    When I fill in the form with an existing parent's name
    Then I should see the family card

  Scenario: An error is shown if the ajax request does not return
    Given AJAX requests do not respond
    Then "the search error alert" should be hidden
    When I fill in the form with an existing parent's name
    And I press "Search Prospect Records"
    Then the search error alert should be visible

  Scenario: No results when search fields are left blank
    When I press "Search Prospect Records"
    Then I should see "No prospects were found"
