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

Then /^I should see the family card audit trail$/ do
  steps %{
    Then I should see the following table rows:
      | *@*03:00PM on 03/22/2013* | *Updated Call Log*Spoke to: Amadeus Cornerstone* | *more details* |
      | *@*03:00PM on 03/22/2013* | *Updated Qualifier*Can eat whole watermelon*     | *more details* |
      | *@*03:00PM on 03/22/2013* | *Updated Family Member*Amadeus Cornerstone*      | *more details* |
      | *@*03:00PM on 03/22/2013* | *Updated Family Member*Ramsy Cornerstone*        | *more details* |
      | *@*03:00PM on 03/22/2013* | *Updated Family Card*Gordon Ramsy*               | *more details* |
      | *@*03:00PM on 03/22/2013* | *Updated Call Log*Spoke to: Amadeus Cornerstone* | *more details* |
      | *@*03:00PM on 03/22/2013* | *Updated Qualifier*Can eat whole watermelon*     | *more details* |
      | *@*03:00PM on 03/22/2013* | *Updated Family Member*Amadeus Cornerstone*      | *more details* |
      | *@*03:00PM on 03/22/2013* | *Updated Family Member*Ramsy Cornerstone*        | *more details* |
      | *@*03:00PM on 03/22/2013* | *Updated Family Card*Gordon Ramsy*               | *more details* |
      | *@*02:00PM on 02/21/2013* | *Created Call Log*Spoke to: Amadeus Cornerstone* | *more details* |
      | *@*02:00PM on 02/21/2013* | *Created Qualifier*Can eat whole watermelon*     | *more details* |
      | *@*02:00PM on 02/21/2013* | *Created Family Member*Amadeus Cornerstone*      | *more details* |
      | *@*02:00PM on 02/21/2013* | *Created Family Member*Ramsy Cornerstone*        | *more details* |
      | *@*02:00PM on 02/21/2013* | *Created Family Card*Gordon Ramsy*               | *more details* |
      | *@*02:00PM on 02/21/2013* | *Created Call Log*Spoke to: Amadeus Cornerstone* | *more details* |
      | *@*02:00PM on 02/21/2013* | *Created Qualifier*Can eat whole watermelon*     | *more details* |
      | *@*02:00PM on 02/21/2013* | *Created Family Member*Amadeus Cornerstone*      | *more details* |
      | *@*02:00PM on 02/21/2013* | *Created Family Member*Ramsy Cornerstone*        | *more details* |
      | *@*02:00PM on 02/21/2013* | *Created Family Card*Gordon Ramsy*               | *more details* |
      | *@*02:00PM on 02/21/2013* | *Created Family Member*Gordon Ramsy*             | *more details* |
  }
end
