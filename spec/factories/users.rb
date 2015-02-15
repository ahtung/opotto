# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { |this| this.password }

    trait :with_jars do
      jars { create_list(:jar, 5) }
    end

    trait :with_contributions do
      contributions { create_list(:contribution, 10) }
    end
  end
end
