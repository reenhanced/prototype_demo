When /^I select the first contact from "(.*)+"$/ do |contact_field|
  @family_card ||= FamilyCard.last
  first_contact = @family_card.contacts.first

  select(first_contact.name, :from => contact_field)
end

Then /^I should( not)? see the call's information?$/ do |negator|
  @family_card ||= FamilyCard.last
  @family_card.reload
  call = @family_card.calls.last

  steps %{
    Then I should see the following table rows:
      | Date               | Spoke to             | Message         |
      | #{call.updated_at} | #{call.contact.name} | #{call.message} |
  }
end
