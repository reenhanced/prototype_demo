Given /the following qualifiers exist:/ do |table|
 table.raw.each do |name|
   create(:qualifier, :name => name.first)
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
