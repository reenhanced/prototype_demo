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

Then /^I should( not)? see the parent's name$/ do |negator|
  @parent_name = "#{FamilyCard.last.parent_first_name} #{FamilyCard.last.parent_last_name}"
  if negator
    step %{I should not see "#{@parent_name}"}
  else
    step %{I should see "#{@parent_name}"}
  end
end
