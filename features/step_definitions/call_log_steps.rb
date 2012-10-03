When /^I select the first contact from "(.*)+"$/ do |contact_field|
  @family_card ||= FamilyCard.last
  first_contact = @family_card.contacts.first

  select(first_contact.name, :from => contact_field)
end

When /^I check the first qualifier$/ do
  @qualifier = Qualifier.first

  check("qualifier_ids_#{@qualifier.id}")
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

Then /^the family card should have the selected qualifier$/ do
  @qualifier ||= Qualifier.first
  @family_card ||= FamilyCard.last

  @family_card.qualifiers.should include(@qualifier)
end

Then /^the selected qualifier should be checked$/ do
  @qualifier ||= Qualifier.first

  step %{the "qualifier_ids_#{@qualifier.id}" checkbox should be checked}
end
