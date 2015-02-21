FactoryGirl.define do
  factory :jar do
    name     { Faker::Name.name }
    end_date { 10.days.from_now }

    trait :with_contributions do
      after :create do |instance|
        instance.contributions = create_list(:contribution, 10, amount: Faker::Commerce.price, jar_id: instance.id)
      end
    end

    trait :with_owner do
      owner { create(:user) }
    end

    trait :with_guests do
      guests { create_list(:user, 3) }
    end
  end
end
