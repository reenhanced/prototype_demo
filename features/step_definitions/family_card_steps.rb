Given /^I have (\d+)( incomplete)? family card[s]?$/ do |card_quantity, incomplete|
  @user = @user || create(:user)
  card_quantity.to_i.times do
    if incomplete
      create(:family_card, :incomplete, user: @user)
    else
      create(:family_card, user: @user)
    end
  end
  @family_card = FamilyCard.last
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

Then /^I should( not)? see the family card$/ do |negator|
  @family_card ||= FamilyCard.last
  @parent_name = "#{FamilyCard.last.parent_first_name} #{FamilyCard.last.parent_last_name}"

  if negator
    step %{I should not see "Family Info"}
    step %{I should not see "Parent/Guardian Name"}
    step %{I should not see "#{@parent_name}"}
    step %{I should not see "Phone"}
    step %{I should not see "#{@family_card.phone}"}
    step %{I should not see "Email"}
    step %{I should not see "#{@family_card.email}"}
    step %{I should not see "Address"}
    step %{I should not see "#{@family_card.address1}"}
    step %{I should not see "#{@family_card.city}, #{@family_card.state} #{@family_card.zip_code}"}
    step %{I should not see "Default Student"}
    step %{I should not see "#{@family_card.student_name}"}
  else
    step %{I should see "Family Info"}
    step %{I should see "Parent/Guardian Name"}
    step %{I should see "#{@parent_name}"}
    step %{I should see "Phone"}
    step %{I should see "#{@family_card.phone}"}
    step %{I should see "Email"}
    step %{I should see "#{@family_card.email}"}
    step %{I should see "Address"}
    step %{I should see "#{@family_card.address1}"}
    step %{I should see "#{@family_card.city}, #{@family_card.state} #{@family_card.zip_code}"}
    step %{I should see "Default Student"}
    step %{I should see "#{@family_card.student_name}"}
  end
end

Then /^I should( not)? see the parent's name$/ do |negator|
  @parent_name = "#{FamilyCard.last.parent_first_name} #{FamilyCard.last.parent_last_name}"
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
