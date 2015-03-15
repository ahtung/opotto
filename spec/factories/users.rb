# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }

    trait :with_jars do
      jars { create_list(:jar, 5) }
    end

    trait :with_invitations do
      after :create do |instance|
        instance.invitations = create_list(:invitation, 10)
      end
    end

    trait :with_name do
      name { Faker::Name.name }
    end
  end
end
