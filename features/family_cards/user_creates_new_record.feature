Feature: User creates a new family card
  In order to create a new family card record
  As a user
  I can follow a link from the search results and fill out a new record form

  Scenario: User creates a new family card record
    Given I am logged in
    And I am on the search family cards page
    Then I should not see "Create new record"
    When I press "Search Prospect Records"
    Then I should see "Create new record"
    When I follow "Create new record"
    And I fill in the following:
      | Parent/Guardian First Name | Dolly                   |
      | Parent/Guardian Last Name  | Parton                  |
      | Phone                      | (911) 555-1212          |
      | Email                      | dollyparton@example.com |
      | family_card_address1       | 123 Easy St             |
      | family_card_address2       | Apt. 2                  |
      | family_card_city           | Los Angelos             |
      | family_card_zip_code       | 90210                   |
    And I select "California" from "family_card_state"
    And I press "Create Family Card"
    Then I should see "Family of: Dolly Parton"
