FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'fodrizzle'
    password_confirmation 'fodrizzle'
  end

  factory :family_member do
    family_card
    email      { Faker::Internet.email }
    phone      { Faker::PhoneNumber.phone_number }
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }

    trait :with_address do
      address1   { Faker::Address.street_address }
      address2   { Faker::Address.secondary_address }
      city       { Faker::Address.city }
      state      { Faker::Address.state_abbr }
      zip_code   { Faker::Address.zip_code }
    end

  end

  factory :student, parent: :family_member, class: Student do
  end

  factory :parent, parent: :family_member, class: Parent, aliases: [:default_parent] do
  end

  factory :family_card do
    user

    after(:create) do |family_card|
      family_card.default_parent = create(:parent, :family_card => family_card)
      family_card.save!
    end
  end

  factory :qualifier do
    name { Faker::Lorem.sentence(5) }
    category "positive"
    position 0
  end
end
