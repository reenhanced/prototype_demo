# IMPORTANT: This file is generated by cucumber-rails - edit at your own peril.
# It is recommended to regenerate this file in the future when you upgrade to a
# newer version of cucumber-rails. Consider adding your own code to a new file
# instead of editing this one. Cucumber will automatically load all features/**/*.rb
# files.


require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )press "([^"]*)"$/ do |button|
  click_button(button)
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link(link)
end

When /^(?:|I )(?:click) "([^"]*)"$/ do |link|
  click_link(link)
end

# Single-line step scoper
When /^(.*) within (.*[^:])$/ do |substep, parent|
  with_scope(parent) { step substep }
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^(?:|I )fill in "([^"]*)" for "([^"]*)"$/ do |value, field|
  fill_in(field, :with => value)
end

# Use this to fill in an entire form with data from a table. Example:
#
#   When I fill in the following:
#     | Account Number | 5002       |
#     | Expiry date    | 2009-11-01 |
#     | Note           | Nice guy   |
#     | Wants Email?   |            |
#
# TODO: Add support for checkbox, select og option
# based on naming conventions.
#
When /^(?:|I )fill in the following:$/ do |fields|
  fields.rows_hash.each do |name, value|
    step %{I fill in "#{name}" with "#{value}"}
  end
end

When /^(?:|I )select "([^"]*)" from "([^"]*)"$/ do |value, field|
  select(value, :from => field)
end

When /^(?:|I )select "([^\"]*)" as the "([^\"]*)" date$/ do |date, label|
  select_date(date, {from: label})
end

When /^(?:|I )select "([^\"]*)" as the "([^\"]*)" date and time$/ do |datetime, selector|
  select_datetime(datetime, :from => selector)
end

When /^(?:|I )check "([^"]*)"$/ do |field|
  check(field)
end

When /^(?:|I )uncheck "([^"]*)"$/ do |field|
  uncheck(field)
end

When /^(?:|I )choose "([^"]*)"$/ do |field|
  choose(field)
end

When /^(?:|I )attach the file "([^"]*)" to "([^"]*)"$/ do |path, field|
  attach_file(field, path)
end

When /^I wait for (\d+) seconds?$/ do |secs|
  sleep secs.to_i
end

When /^I wait for the ajax to finish$/ do
  wait_until {
    page.evaluate_script('jQuery.active') == 0
  }
end

Then /^(?:|I )should see JSON:$/ do |expected_json|
  require 'json'
  expected = JSON.pretty_generate(JSON.parse(expected_json))
  actual   = JSON.pretty_generate(JSON.parse(response.body))
  expected.should == actual
end

Then /^(?:|I )should see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

Then /^(.*) should( not)? have rendered$/ do |selector, negator|
  unless negator
    page.should have_selector(selector_for selector)
  else
    page.should_not have_selector(selector_for selector)
  end
end

Then /^(?:|I )should see \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)
  if page.respond_to? :should
    page.should have_xpath('//*', :text => regexp)
  else
    assert page.has_xpath?('//*', :text => regexp)
  end
end

Then /^(?:|I )should not see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_no_content(text)
  else
    assert page.has_no_content?(text)
  end
end

Then /^(?:|I )should not see \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)
  if page.respond_to? :should
    page.should have_no_xpath('//*', :text => regexp)
  else
    assert page.has_no_xpath?('//*', :text => regexp)
  end
end

Then /^the "([^"]*)" hidden field should contain "([^"]*)"$/ do |field, value|
  find(:xpath, "//input[@id='#{field}']").value.should =~ /#{Regexp.quote(value)}/
end

Then /^the "([^"]*)" field should contain "([^"]*)"$/ do |field, value|
  field = find_field(field)
  field_value = (field.tag_name == 'textarea') ? field.text : field.value
  if field_value.respond_to? :should
    field_value.should =~ /#{Regexp.quote(value)}/
  else
    assert_match(/#{value}/, field_value)
  end
end

Then /^the "([^"]*)" field should not contain "([^"]*)"$/ do |field, value|
  field = find_field(field)
  field_value = (field.tag_name == 'textarea') ? field.text : field.value
  if field_value.respond_to? :should_not
    field_value.should_not =~ /#{value}/
  else
    assert_no_match(/#{value}/, field_value)
  end
end

Then /^the "([^"]*)" checkbox should be checked$/ do |label|
  field_checked = find_field(label)['checked']
  if field_checked.respond_to? :should
    field_checked.should be_true
  else
    assert field_checked
  end
end

Then /^the "([^"]*)" checkbox should not be checked$/ do |label|
  field_checked = find_field(label)['checked']
  if field_checked.respond_to? :should
    field_checked.should be_false
  else
    assert !field_checked
  end
end

Then /^I should see a checkbox labeled "([^"]*)"$/ do |label_text|
    label = find('label', :text => label_text)
    page.should have_selector("input##{label['for']}[type=checkbox]")
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

Then /^(?:|I )should have the following query string:$/ do |expected_pairs|
  query = URI.parse(current_url).query
  actual_params = query ? CGI.parse(query) : {}
  expected_params = {}
  expected_pairs.rows_hash.each_pair{|k,v| expected_params[k] = v.split(',')}

  if actual_params.respond_to? :should
    actual_params.should == expected_params
  else
    assert_equal expected_params, actual_params
  end
end

Then /^show me the page$/ do
  save_and_open_page
end

Then /^I should see the (.* )?image "(.+)"$/ do |style, image|
  style ||= "medium"
  page.should have_xpath("//img[contains(@src, \"#{style.strip}/#{image}\")]")
end

Then /^(.*) should be (visible|hidden)$/ do |descriptor, visible|
  if visible == 'visible'
    find(selector_for descriptor).should be_visible
  else
    find(selector_for descriptor).should_not be_visible
  end
end

Then /(.*) should be (collapsed|expanded)$/ do |selector, element_state|
  selector = selector_for(selector)
  if element_state == 'collapsed'
    page.has_css?("#{selector}, [contains(@style,'height: 0px')]")
  else
    page.has_no_css?("#{selector}, [contains(@style,'height: 0px')]")
  end
end

Then /^the "([^\"]+)" field should( not)? be disabled$/ do |field, negator|
  if negator
    find_field(field)['disabled'].should_not be_true
  else
    find_field(field)['disabled'].should be_true
  end
end
