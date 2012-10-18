Feature: Admin views family card

  As an admin
  I want to view a family card
  To see it's full details

  Scenario: Admin can view a card he didn't create
    Given I am logged in as an admin
    And there is 1 family card
    And I do not own the family card
    When I go to the family card's page
    Then I should see the family card
