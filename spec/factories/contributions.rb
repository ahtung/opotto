# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contribution do
    amount { Faker::Commerce.price }
    association :pot, strategy: :build
    association :user, strategy: :build
    anonymous { [true, false].sample }
    state 'initiated'
    preapproval_key 'GOOD_KEY'

    trait :scheduled do
      state 'scheduled'
    end

    trait :completed do
      state 'completed'
    end

    trait :anonymous do
      anonymous { true }
    end

    trait :with_user_noname do
      user { create(:user) }
    end

    trait :with_user_with_name do
      user { create(:user, :with_name) }
    end
  end
end
