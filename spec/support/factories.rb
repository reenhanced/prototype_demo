FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'fodrizzle'
    password_confirmation 'fodrizzle'

    trait :admin do
      after(:build) do |user|
        user.roles = ['admin']
      end
    end
  end

  factory :family_member, aliases: [:default_parent] do
    family_card
    email      { Faker::Internet.email }
    phone      { Faker::PhoneNumber.phone_number }
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
  end

  factory :student, parent: :family_member, class: Student do
  end

  factory :parent, parent: :family_member do
    relationship "Mother"
    type "FamilyMember"
  end

  factory :family_card do
    user
    parent_first_name { Faker::Name.first_name }
    parent_last_name  { Faker::Name.last_name }
    parent_email      { Faker::Internet.email }
    parent_phone      { Faker::PhoneNumber.phone_number }

    trait :with_address do
      parent_address1   { Faker::Address.street_address }
      parent_address2   { Faker::Address.secondary_address }
      parent_city       { Faker::Address.city }
      parent_state      { Faker::Address.state_abbr }
      parent_zip_code   { Faker::Address.zip_code }
    end
  end

  factory :call_log do
    family_card
    message     { Faker::Lorem.sentence(10) }
    recorded_at { DateTime.now }

    trait :with_qualifiers do
      after(:build) do |call_log|
        call_log.qualifier_ids = [
          FactoryGirl.create(:qualifier, category: 'positive').id,
          FactoryGirl.create(:qualifier, category: 'neutral').id,
          FactoryGirl.create(:qualifier, category: 'negative').id
        ]
      end
    end
  end

  factory :qualifier do
    name     { Faker::Lorem.sentence(5) }
    category "positive"
    position 0
  end
end
