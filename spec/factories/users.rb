# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Number.number(8) }
    admin 'false'

    trait :with_pots do
      pots { create_list(:pot, 2, :open) }
    end

    trait :with_closed_pots do
      pots { create_list(:pot, 2, :closed) }
    end

    trait :with_invitations do
      after :create do |instance|
        instance.invitations = create_list(:invitation, 2)
      end
    end

    trait :with_name do
      name { Faker::Name.name }
    end

    trait :registered do
      last_sign_in_at { Faker::Date.between(2.days.ago, Time.zone.now) }
    end

    trait :with_contributions do
      after :create do |instance|
        instance.contributions = create_list(:contribution, 2, amount: Faker::Commerce.price)
      end
    end

    trait :admin do
      admin 'true'
    end
  end
end
