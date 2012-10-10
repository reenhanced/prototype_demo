Then /^the family card should have (\d+) parent[s]?$/ do |parent_count|
  @family_card ||= FamilyCard.last
  @family_card.reload
  @family_card.parents.should have(parent_count).parents
end

Then /^I should( not)? see the parent's information( with the default parent's contact info)?$/ do |negator, matches_default_parent|
  @family_card ||= FamilyCard.last
  @family_card.reload
  parent         = @family_card.parents.last
  new_parent_address = "*#{parent.address1}*#{parent.address2}*#{parent.city}, #{parent.state} #{parent.zip_code}*"
  default_parent_address = "*#{@family_card.parent_address1}*#{@family_card.parent_address2}*#{@family_card.parent_city}, #{@family_card.parent_state} #{@family_card.parent_zip_code}*"

  if matches_default_parent
    steps %{
      Then I should see the following table rows:
        | First Name           | Last Name           | Email                        | Phone                        | Address           |
        | #{parent.first_name} | #{parent.last_name} | #{@family_card.parent_email} | #{@family_card.parent_phone} | #{default_parent_address} |
    }
  else
    steps %{
      Then I should see the following table rows:
        | First Name           | Last Name           | Email           | Phone           | Address           |
        | #{parent.first_name} | #{parent.last_name} | #{parent.email} | #{parent.phone} | #{new_parent_address} |
    }
  end
end
