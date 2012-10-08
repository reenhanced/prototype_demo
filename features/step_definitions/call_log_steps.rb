Given /^I have initial qualifiers$/ do
  3.times do
    create(:qualifier, category: 'positive')
    create(:qualifier, category: 'neutral')
    create(:qualifier, category: 'negative')
  end
end

Given /^the call log has qualifiers$/ do
  steps "Given I have initial qualifiers"
  call = CallLog.last
  call.qualifier_ids = Qualifier.select(:id).collect {|q| q.id}
  call.save!
end

When /^I select the first member from (.*)+$/ do |member_field|
  @family_card ||= FamilyCard.last
  first_member= @family_card.family_members.first

  select(first_member.name, :from => member_field)
end

When /^I check the first qualifier$/ do
  @qualifier = Qualifier.first

  check("qualifier_ids_#{@qualifier.id}")
end

Then /^I should( not)? see the call's information?$/ do |negator|
  @family_card ||= FamilyCard.last
  @family_card.reload
  calls = @family_card.calls.last(2)
  first_call = calls.first
  second_call = calls.last

  steps %{
    Then I should see the following table rows:
      | Date                       | Spoke to                    | Message                |
      | #{first_call.recorded_at}  | #{first_call.contact.name}  | #{first_call.message}  |
      | #{second_call.recorded_at} | #{second_call.contact.name} | #{second_call.message} |
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

Then /^the call should have recorded the date and time$/ do
  call = CallLog.last
  call.recorded_at.should_not be_nil
end

Then /^I should see the call log details(?: within ([^"]*))?$/ do |selector|
  call = CallLog.last
  qualifier = call.family_card.qualifiers.first
  with_scope(selector) do
    call_details_selector = "the call log details for ##{call.id}"
    call_details = find(selector_for(call_details_selector))
    call_details.should be_visible
    steps %{
      Then I should see "Spoke to: #{call.contact.name}" within #{call_details_selector}
      And I should see "#{call.recorded_at}" within #{call_details_selector}
      And I should see "#{qualifier.name}" within #{call_details_selector}
    }
  end
end
