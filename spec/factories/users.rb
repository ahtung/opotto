# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }

    trait :with_jars do
      jars { create_list(:jar, 5) }
    end

    trait :with_contributions do
      after :create do |instance|
        instance.contributions = create_list(:contribution, 10, amount: Faker::Commerce.price, jar_id: Jar.select(:id).sample)
      end
    end
  end
end
