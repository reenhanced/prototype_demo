FactoryGirl.define do
  factory :user do
    email 'example@example.com'
    password 'please'
    password_confirmation 'please'
  end

  factory :family_card do
    parent_first_name Faker::Name.first_name
    parent_last_name Faker::Name.last_name
    student_name Faker::Name.name
    phone Faker::PhoneNumber.phone_number
    email Faker::Internet.email
  end
end
