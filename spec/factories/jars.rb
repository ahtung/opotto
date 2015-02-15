FactoryGirl.define do
  factory :jar do
    name { Faker::Name.name }

    trait :with_contributions do
      after :create do |instance|
        instance.contributions = create_list(:contribution, 10, amount: Faker::Commerce.price, jar_id: instance.id)
      end
    end

    trait :with_owner do
      owner { create(:user) }
    end
  end
end
