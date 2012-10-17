Feature: Admin views family card

  As an admin
  I want to view a family card
  To see it's full details

  Scenario: Admin can view a card he didn't create
    Given there is 1 family card
    And I am logged in as an admin
    When I go to the family card's page
    Then I should see the family card
