FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'fodrizzle'
    password_confirmation 'fodrizzle'
  end

  factory :parent, aliases: [:default_parent] do
    family_card
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone { Faker::PhoneNumber.phone_number }
  end

  factory :student do
    family_card
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone { Faker::PhoneNumber.phone_number }
    address1 { Faker::Address.street_address }
    address2 { Faker::Address.secondary_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip_code { Faker::Address.zip_code }

    trait :incomplete do
      address2 ''
    end
  end

  factory :family_card do
    user
    address1 { Faker::Address.street_address }
    address2 { Faker::Address.secondary_address }
    city { Faker::Address.city }
    email { Faker::Internet.email }
    parent_first_name { Faker::Name.first_name }
    parent_last_name { Faker::Name.last_name }
    phone { Faker::PhoneNumber.phone_number }
    state { Faker::Address.state_abbr }
    student_name { Faker::Name.name }
    zip_code { Faker::Address.zip_code }

    trait :incomplete do
      address2 ''
    end
  end

  factory :qualifier do
    family_card
    name { Faker::Lorem.sentence(5) }
    category "positive"
    position 0
  end
end
