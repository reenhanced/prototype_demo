Given /the following qualifiers exist:/ do |table|
 table.hashes.each do |attrs|
   create(:qualifier, attrs)
 end
end

When /I click the edit link for the "([^"]+)" qualifier/ do |name|
  qualifier = fetch(:qualifier, :name => name)
  within("#qualifier_#{qualifier.id}") { click_link "Edit" }
end

When /I delete the "([^"]+)" qualifier/ do |name|
  qualifier = fetch(:qualifier, :name => name)
  within("#qualifier_#{qualifier.id}") { click_link "Delete" }
end

When /^I drag qualifier "([^"]+)" to the top of the list$/ do |name|
  first_qualifier = Qualifier.ordered.first
  named_qualifier = Qualifier.where(:name => name).first

  dom_to_drag = page.find("#qualifier_#{named_qualifier.id} i")
  top_of_list_dom = page.find("#qualifier_#{first_qualifier.id}")

  dom_to_drag.drag_to(top_of_list_dom)
end

Then /^I should see the qualifiers in the following order:$/ do |table|
  qualifier_names = table.raw.map { |array| array.first }

  steps %{
    Then I should see the following table rows:
      | Qualifier | Actions |
      #{qualifier_names.map { |name|
        "| #{name} | Edit |" }.join("\n") }
  }
end

Then /^I should see qualifier checkboxes in the following order:$/ do |table|
  qualifier_names = table.raw.map { |array| array.first }
  qualifiers = qualifier_names.map { |name| Qualifier.find_by_name name }

  all_labels = page.all('#qualifier_checkboxes label')

  qualifiers.each_with_index do |qualifier, index|
    label = all_labels[index]
    label[:for].should == "qualifier_ids_#{qualifier.id}"
  end
end
