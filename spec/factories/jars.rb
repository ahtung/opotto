FactoryGirl.define do
  factory :jar do
    name     { Faker::Name.name }
    end_at   { 10.days.from_now }
    owner    { create(:user) }

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

    trait :open do
    end

    trait :closed do
      after :create do |model|
        model.update_column(:end_at, 3.days.ago)
      end
    end

    trait :ended do
      after :create do |model|
        model.update_column(:end_at, 8.days.ago)
      end
    end
  end
end
