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

