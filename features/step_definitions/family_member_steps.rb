Then /^the family card should have (\d+) family member[s]?$/ do |family_member_count|
  @family_card ||= FamilyCard.last
  @family_card.reload
  @family_card.family_members.should have(family_member_count).family_members
end

Then /^I should( not)? see the family member's information( with the default family member's contact info)?$/ do |negator, matches_default_parent|
  @family_card ||= FamilyCard.last
  @family_card.reload

  family_member                 = @family_card.family_members.last
  family_member_address         = "*#{family_member.address1}*#{family_member.address2}*#{family_member.city}, #{family_member.state} #{family_member.zip_code}*"
  default_parent_address = "*#{@family_card.parent_address1}*#{@family_card.parent_address2}*#{@family_card.parent_city}, #{@family_card.parent_state} #{@family_card.parent_zip_code}*"

  if matches_default_parent
    steps %{
      Then I should see the following table rows:
        | First Name           | Last Name           | Email                        | Phone                        | Address           |
        | #{family_member.first_name} | #{family_member.last_name} | #{@family_card.parent_email} | #{@family_card.parent_phone} | #{default_parent_address} |
    }
  else
    steps %{
      Then I should see the following table rows:
        | First Name           | Last Name           | Email           | Phone           | Address           |
        | #{family_member.first_name} | #{family_member.last_name} | #{family_member.email} | #{family_member.phone} | #{family_member_address} |
    }
  end
end
