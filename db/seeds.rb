# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'factory_girl'
require "#{Rails.root}/spec/support/factories.rb"

unless User.any?
  user = FactoryGirl.create(:user, email: 'test@example.com', password: 'password', password_confirmation: 'password')
  admin = FactoryGirl.create(:user, :admin, email: 'admin@example.com', password: 'password', password_confirmation: 'password')
end

unless FamilyCard.any?
  user ||= User.last
  # this will automatically create the default_parent as well
  family_card = FactoryGirl.create(:family_card, :with_address, user: user, parent_first_name: 'John', parent_last_name: 'Smith', parent_phone: '215-804-9408', parent_email: 'smiths@example.com', parent_address1: '312 West Broad Street', parent_address2: 'In the back', parent_city: 'Quakertown', parent_state: 'PA', parent_zip_code: '18951')
end

family_card ||= FamilyCard.last

unless family_card.students.any?
  3.times do
    FactoryGirl.create(:student, family_card: family_card)
  end
end

unless Qualifier.any?
  # Qualifiers without a family_id are used to populate check lists throughout the site
  FactoryGirl.create(:qualifier, name: "Looking to enroll shortly", category: "positive", position: 0)
  FactoryGirl.create(:qualifier, name: "Student(s) have been withdrawn/expelled", category: "positive", position: 1)
  FactoryGirl.create(:qualifier, name: "Dissatisfied with current education", category: "positive", position: 2)
  FactoryGirl.create(:qualifier, name: "Referred by a friend", category: "positive", position: 3)
  FactoryGirl.create(:qualifier, name: "Previous Bridgeway Student", category: "positive", position: 4)

  FactoryGirl.create(:qualifier, name: "Eligible for scholorship", category: "neutral", position: 0)
  FactoryGirl.create(:qualifier, name: "Looking for future school year", category: "neutral", position: 1)
  FactoryGirl.create(:qualifier, name: "Researching other program", category: "neutral", position: 2)
  FactoryGirl.create(:qualifier, name: "Seeking accredited diploma", category: "neutral", position: 3)

  FactoryGirl.create(:qualifier, name: "Limited income", category: "negative", position: 0)
  FactoryGirl.create(:qualifier, name: "Looking for free program/financial aid", category: "negative", position: 1)
  FactoryGirl.create(:qualifier, name: "Opposed to any form of Christian content", category: "negative", position: 2)
end
