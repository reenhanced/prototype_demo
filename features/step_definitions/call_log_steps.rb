Given /^I have a call log with the following qualifiers?:$/ do |table|
  @user ||= create(:user)
  @family_card ||= create(:family_card, user: @user)
  qualifiers = []
  table.hashes.each do |qualifier_attributes|
    qualifiers << create(:qualifier, qualifier_attributes).id
  end
  create(:call_log, family_card: @family_card, contact: @family_card.family_members.last)
end

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

Given /^I have a (.*) qualifier with "(.*)"$/ do |category, name|
  create(:qualifier, category: category, name: name)
end

When /^I select the first member from (.+)$/ do |member_field|
  @family_card ||= FamilyCard.last
  first_member= @family_card.family_members.first

  select(first_member.name, :from => selector_for(member_field))
end

When /^I (un)?check the first qualifier$/ do |unchecked|
  @qualifier = Qualifier.first

  if unchecked
    uncheck("qualifier_ids_#{@qualifier.id}")
  else
    check("qualifier_ids_#{@qualifier.id}")
  end
end

Then /^I should( not)? see the call's information?$/ do |negator|
  @family_card ||= FamilyCard.last
  @family_card.reload
  call_logs = @family_card.call_logs.last(2)
  first_call = call_logs.first
  second_call = call_logs.last

  steps %{
    Then I should see the following table rows:
      | Call recorded at           | Spoke to                    | Message                |
      | #{first_call.recorded_at}  | #{first_call.contact.name}  | #{first_call.message}  |
      | #{second_call.recorded_at} | #{second_call.contact.name} | #{second_call.message} |
  }
end

Then /^the family card should( not)? have the selected qualifier$/ do |negator|
  @qualifier ||= Qualifier.first
  @family_card ||= FamilyCard.last
  @qualifier.reload
  @family_card.reload
  @family_card.qualifiers.reload

  if negator
    @family_card.qualifiers.should_not include(@qualifier)
  else
    @family_card.qualifiers.should include(@qualifier)
  end
end

Then /^the selected qualifier should( not)? be checked$/ do |negator|
  @qualifier ||= Qualifier.first

  step %{the "qualifier_ids_#{@qualifier.id}" checkbox should#{negator} be checked}
end

Then /^the call should have recorded the date and time$/ do
  call = CallLog.last
  call.recorded_at.should_not be_nil
end

Then /^I should see the call log details?$/ do
  call                  = CallLog.last
  qualifier             = call.family_card.qualifiers.first
  call_details_selector = "the call log details for ##{call.id}"
  find(selector_for(call_details_selector)).should be_visible

  steps %{
    Then I should see "Spoke to #{call.contact.name}" within #{call_details_selector}
    And I should see "#{call.recorded_at}" within #{call_details_selector}
    And I should see "#{qualifier.name}" within #{call_details_selector}
  }
end
