# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contribution do
    amount { Faker::Commerce.price }
    jar
    user
    anonymous { [true, false].sample }
    state 'initiated'

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
