Then /^I should( not)? see the call's information?$/ do |negator|
  @family_card ||= FamilyCard.last
  @family_card.reload
  call = @family_card.calls.last

  steps %{
    Then I should see the following table rows:
      | Date               | Message         |
      | #{call.updated_at} | #{call.message} |
  }
end
