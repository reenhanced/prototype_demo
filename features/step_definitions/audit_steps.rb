Given /^all possible audits exist(?: for a family card)$/ do
  # Creates
  steps %{
    Given the time is "21 Feb 2013 01:00PM"
  }
  @family_card ||= create(:family_card, parent_first_name: "Gordon", parent_last_name: "Ramsy")
  student = create(:student, family_card: @family_card, first_name: "Ramsy", last_name: "Cornerstone")
  parent = create(:parent, family_card: @family_card, first_name: "Amadeus", last_name: "Cornerstone")
  qualifier = create(:qualifier, name: "Can eat own bugers", category: "negative")
  call_log = create(:call_log, family_card: @family_card, contact_id: parent.id, contact_type: parent.class)
  call_log.qualifier_ids = [qualifier.id]
  call_log.save!

  # Updates
  steps %{
    Given the time is "22 Mar 2013 02:00PM"
  }
  @family_card.update_attributes!(parent_first_name: "Carson", parent_last_name: "Daily")
  student.update_attributes!(first_name: "Dawson", last_name: "Lawson")
  parent.update_attributes!(first_name: "Larry", last_name: "Lawson")
  qualifier.update_attributes!(name: "Can eat whole watermelon", category: "positive")
  call_log.update_attributes!(contact_id: student.id, contact_type: student.class)
  call_log.qualifier_ids = []
  call_log.save!

  # Destroys
  call_log.destroy
  qualifier.destroy
  parent.destroy
  student.destroy
end

Then /^I should see the audit trail details for the created family card$/ do
  @family_card   ||= FamilyCard.last
  default_parent   = @family_card.default_parent
  steps %{
    Then I should see the following table rows:
      | Changed        | From | To                           |
      | user_id        |      | #{@family_card.user.id}      |
      | family_card_id |      | #{@family_card.id}           |
      | first_name     |      | #{default_parent.first_name} |
      | last_name      |      | #{default_parent.last_name} |
      | address1       |      | #{default_parent.address1}   |
      | address2       |      | #{default_parent.address2}   |
      | city           |      | #{default_parent.city}       |
      | state          |      | #{default_parent.state}      |
      | zip_code       |      | #{default_parent.zip_code}   |
      | phone          |      | #{default_parent.phone}      |
      | email          |      | #{default_parent.email}      |
  }
end
