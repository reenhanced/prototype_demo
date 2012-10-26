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

    after(:build) do |call_log|
      call_log.contact ||= create(:family_member, family_card: call_log.family_card)
    end

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

  factory :family_card_qualifier do
    family_card
    qualifier
  end

  factory :audit do
    user
    association :auditable, factory: :student
    association :associated, factory: :family_card
    action "create"

    after(:build) do |audit|
      if audit.auditable_type == "FamilyCard"
        audit.associated_id = audit.associated_type = nil
      end

      audit.audited_changes = {}
      if audit.action =~ /create|destroy/
        audit.audited_changes[audit.auditable.audited_attributes.first[0]] = 1
      else
        audit.audited_changes[audit.auditable.audited_attributes.first[0]] = [1,2]
      end
    end

    trait :with_migrated_data do
      after(:build) do |audit|
        if audit.action =~ /create|destroy/
          audit.audited_changes = {primary_parent_id: 1}
        else
          audit.audited_changes = {primary_parent_id: [1,2]}
        end
      end
    end

    trait :with_old_model_references do
      after(:create) do |audit|
        audit.auditable_type = "Student"
        audit.auditable_id = 1
        audit.save!
      end
    end
  end
end
