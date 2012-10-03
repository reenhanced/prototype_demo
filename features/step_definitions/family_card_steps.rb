Given /^I have (\d+)( incomplete)? family card[s]?$/ do |card_quantity, incomplete|
  @user = @user || create(:user)
  card_quantity.to_i.times do
    if incomplete
      create(:family_card, user: @user)
    else
      create(:family_card, :with_address, user: @user)
    end
  end
  @family_card = FamilyCard.last
end

Given /^I have initial qualifiers$/ do
  3.times do
    create(:qualifier, category: 'positive')
    create(:qualifier, category: 'neutral')
    create(:qualifier, category: 'negative')
  end
end

When /^I fill in the form with an existing parent's name$/ do
  @family_card = FamilyCard.last
  @parent_name = "#{@family_card.parent_first_name} #{@family_card.parent_last_name}"

  step "I fill in \"Parent/Guardian First Name\" with \"#{@family_card.parent_first_name}\""
  step "I fill in \"Parent/Guardian Last Name\" with \"#{@family_card.parent_last_name}\""
end

When /^I follow the parent's name$/ do
  step "I follow \"#{@parent_name}\""
end

Then /^I should( not)? see the( detailed)? family card$/ do |negator, detailed|
  @family_card ||= FamilyCard.last
  @parent_name = "#{FamilyCard.last.parent_first_name} #{FamilyCard.last.parent_last_name}"

  step %{I should#{negator} see "Family Info"}
  step %{I should#{negator} see "Parent/Guardian Name"}
  step %{I should#{negator} see "#{@parent_name}"}
  step %{I should#{negator} see "Phone"}
  step %{I should#{negator} see "#{@family_card.parent_phone}"}
  step %{I should#{negator} see "Email"}
  step %{I should#{negator} see "#{@family_card.parent_email}"}
  step %{I should#{negator} see "Address"}
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
  @parent_name = FamilyCard.last.parent_name
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

Then /^the family card's student fields should( not)? be filled in$/ do |negator|
  @family_card ||= FamilyCard.last
  student = @family_card.students.last

  if negator
    step %{the "student_email" field should contain ""}
    step %{the "student_phone" field should contain ""}
    step %{the "student_address1" field should contain ""}
    step %{the "student_address2" field should contain ""}
    step %{the "student_city" field should contain ""}
    step %{the "student_zip_code" field should contain ""}
  else
    step %{the "student_email" field should contain "#{student.email}"}
    step %{the "student_phone" field should contain "#{student.phone}"}
    step %{the "student_address1" field should contain "#{student.address1}"}
    step %{the "student_address2" field should contain "#{student.address2}"}
    step %{the "student_city" field should contain "#{student.city}"}
    step %{the "student_zip_code" field should contain "#{student.zip_code}"}
  end
end

Then /^the family card's student fields should( not)? be disabled$/ do |negator|
  step %{the "student_email" field should#{negator} be disabled}
  step %{the "student_phone" field should#{negator} be disabled}
  step %{the "student_address1" field should#{negator} be disabled}
  step %{the "student_address2" field should#{negator} be disabled}
  step %{the "student_city" field should#{negator} be disabled}
  step %{the "student_zip_code" field should#{negator} be disabled}
end
