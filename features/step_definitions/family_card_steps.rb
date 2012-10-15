Given /^I have (\d+)( incomplete)? (.*)[s]?$/ do |quantity, incomplete, factory_type|
  @user = @user || create(:user)
  quantity.to_i.times do
    case factory_type
    when /family card/i
      if incomplete
        create(:family_card, user: @user)
      else
        create(:family_card, :with_address, user: @user)
      end
    when /call log/i
      @family_card = FamilyCard.last || create(:family_card, user: @user)
      create(:call_log, family_card: @family_card, contact: create(:parent, family_card: @family_card))
    end
  end
  @family_card = FamilyCard.last
end

Given /^I have a family card with parent "(.*)"$/ do |parent_name|
  parent_name = parent_name.split(' ')
  @user       = @user || create(:user)
  @family_card = create(:family_card, user: @user, parent_first_name: parent_name[0], parent_last_name: parent_name[1])
end

When /^I fill in the form with an existing parent's name$/ do
  step "I fill in \"family_member_first_name\" with \"#{@family_card.parent_first_name}\""
  step "I fill in \"family_member_last_name\" with \"#{@family_card.parent_last_name}\""
end

When /^I follow the parent's name$/ do
  step "I follow \"#{@parent_name}\""
end

Then /^I should( not)? see the( detailed)? family card$/ do |negator, detailed|
  @family_card ||= FamilyCard.last
  @parent_name = @family_card.default_parent.name

  step %{I should#{negator} see "Family Info"}
  step %{I should#{negator} see "Parent/Guardian Name"}
  step %{I should#{negator} see "#{@parent_name}"}
  step %{I should#{negator} see "#{@family_card.parent_phone}"}
  step %{I should#{negator} see "#{@family_card.parent_email}"}
  step %{I should#{negator} see "#{@family_card.parent_address1}"}
  step %{I should#{negator} see "#{@family_card.parent_city}"}
  step %{I should#{negator} see "#{@family_card.parent_state}"}
  step %{I should#{negator} see "#{@family_card.parent_zip_code}"}
  step %{I should#{negator} see "Default Student"}
  step %{I should#{negator} see "#{@family_card.default_student.name}"}

  if detailed
    step %{I should#{negator} see "All students"}
  end
end

Then /^I should( not)? see the parent's name$/ do |negator|
  @parent_name = FamilyCard.last.default_parent.name
  if negator
    step %{I should not see "#{@parent_name}"}
  else
    step %{I should see "#{@parent_name}"}
  end
end

Then /^I should own the family card$/ do
  @family_card ||= FamilyCard.last
  @family_card.user.should == @user
end

Then /^the family card's (student|family member) fields should( not)? be filled in$/ do |model_type, negator|
  @family_card ||= FamilyCard.last
  @student = @family_card.students.last || @family_card.students.build
  model_type = model_type.parameterize('_')

  if negator
    step %{the "#{model_type}_email" field should contain ""}
    step %{the "#{model_type}_phone" field should contain ""}
    step %{the "#{model_type}_address1" field should contain ""}
    step %{the "#{model_type}_address2" field should contain ""}
    step %{the "#{model_type}_city" field should contain ""}
    step %{the "#{model_type}_zip_code" field should contain ""}
  else
    step %{the "#{model_type}_email" field should contain "#{@student.email}"}
    step %{the "#{model_type}_phone" field should contain "#{@student.phone}"}
    step %{the "#{model_type}_address1" field should contain "#{@student.address1}"}
    step %{the "#{model_type}_address2" field should contain "#{@student.address2}"}
    step %{the "#{model_type}_city" field should contain "#{@student.city}"}
    step %{the "#{model_type}_zip_code" field should contain "#{@student.zip_code}"}
  end
end

Then /^the family card's (student|family member) fields should( not)? be disabled$/ do |model_type, negator|
  model_type = model_type.parameterize('_')
  step %{the "#{model_type}_email" field should#{negator} be disabled}
  step %{the "#{model_type}_phone" field should#{negator} be disabled}
  step %{the "#{model_type}_address1" field should#{negator} be disabled}
  step %{the "#{model_type}_address2" field should#{negator} be disabled}
  step %{the "#{model_type}_city" field should#{negator} be disabled}
  step %{the "#{model_type}_zip_code" field should#{negator} be disabled}
end

Then /I should see all the family cards/ do
  FamilyCard.all.each do |card|
    page.should have_selector("#family_card_#{card.id}")
  end
end
