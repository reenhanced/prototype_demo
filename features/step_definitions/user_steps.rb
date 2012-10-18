### UTILITY METHODS ###
# credit: https://github.com/RailsApps/rails3-devise-rspec-cucumber/blob/master/features/step_definitions/user_steps.rb

def create_visitor(email=nil)
  @visitor ||= { :name => "Testy McUserton", :email => (email || Faker::Internet.email),
    :password => "fodrizzle", :password_confirmation => "fodrizzle" }
end

def find_user
  @user ||= User.where(:email => @visitor[:email]).first
end

def create_unconfirmed_user
  create_visitor
  delete_user
  sign_up
  visit '/logout'
end

def create_user(options = {})
  create_visitor(options[:email])
  delete_user(options[:email])
  @user = create(:user, options[:role], email: @visitor[:email])
end

def delete_user(email=nil)
  @user ||= User.where(:email => (email || @visitor[:email])).first
  @user.destroy unless @user.nil?
end

def sign_up
  delete_user
  visit '/signup'
  fill_in "Name", :with => @visitor[:name]
  fill_in "Email", :with => @visitor[:email]
  fill_in "Password", :with => @visitor[:password]
  fill_in "Password confirmation", :with => @visitor[:password_confirmation]
  click_button "Sign up"
  find_user
end

def sign_in
  visit '/login'
  fill_in "Email", :with => @visitor[:email]
  fill_in "Password", :with => @visitor[:password]
  click_button "Sign in"
end

### GIVEN ###
Given /^I am not logged in$/ do
  visit '/logout'
end

Given /^I am logged in(?: as an? (.*))?$/ do |role|
  if role
    create_user(:role => role.to_sym)
  else
    create_user
  end
  sign_in
end

Given /^I am logged in as "([^"]*)"$/ do |user_email|
  create_user(:email => user_email)
  sign_in
end

Given /^I exist as a user$/ do
  create_user
end

Given /^I exist as an admin$/ do
  create_user(:role => :admin)
end

Given /^I do not exist as a user$/ do
  create_visitor
  delete_user
end

Given /^I exist as an unconfirmed user$/ do
  create_unconfirmed_user
end

### WHEN ###
When /^I sign in with valid credentials$/ do
  create_visitor
  sign_in
end

When /^I sign out$/ do
  visit '/logout'
end

When /^I sign up with valid user data$/ do
  create_visitor
  sign_up
end

When /^I sign up with an invalid email$/ do
  create_visitor
  @visitor = @visitor.merge(:email => "notanemail")
  sign_up
end

When /^I sign up without a password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "")
  sign_up
end

When /^I sign up without a password$/ do
  create_visitor
  @visitor = @visitor.merge(:password => "")
  sign_up
end

When /^I sign up with a mismatched password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "please123")
  sign_up
end

When /^I sign in with a wrong email$/ do
  @visitor = @visitor.merge(:email => "wrong@example.com")
  sign_in
end

When /^I sign in with a wrong password$/ do
  @visitor = @visitor.merge(:password => "wrongpass")
  sign_in
end

### THEN ###
Then /^I should be signed in$/ do
  page.should have_content "Logout"
  page.should_not have_content "Sign in"
end

Then /^I should be signed out$/ do
  page.should have_content "Sign in"
  page.should_not have_content "Logout"
end

Then /^I should see my email$/ do
  create_user
  page.should have_content @user[:email]
end
