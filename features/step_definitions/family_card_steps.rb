Given /^I have ([0-9]+) family cards$/ do |card_quantity|
  user = @user || FactoryGirl.create(:user)
  card_quantity.to_i.times do
    FactoryGirl.create(:family_card, user: user)
  end
end

When /^I fill in the form with an existing parent's name$/ do
  @parent ||= (Parent.last || FactoryGirl.create(:family_card, :user => @user))

  step "I fill in \"Parent/Guardian First Name\" with \"#{@parent.first_name}\""
  step "I fill in \"Parent/Guardian Last Name\" with \"#{@parent.last_name}\""
end

Then /^I should see the parent's name$/ do
  step %{I should see "#{@parent.name}"}
end
