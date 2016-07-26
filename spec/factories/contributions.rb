# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contribution do
    amount { '200' }
    association :pot, strategy: :build
    association :user, strategy: :build
    anonymous { [true, false].sample }
    state 'initiated'

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
  end
end
