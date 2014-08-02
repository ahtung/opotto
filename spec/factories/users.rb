# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { |this| this.password }
    
    trait :with_jars do
      jars { FactoryGirl.create_list(:jar, 5) }
    end
    
    trait :with_contributions do
      contributions { FactoryGirl.create_list(:contribution, 5) }
    end
  end
end
