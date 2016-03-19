FactoryGirl.define do
  factory :jar do
    name     { Faker::Name.name }
    end_at   { 10.days.from_now }
    association :owner, factory: :user
    association :receiver, factory: :user

    trait :with_contributions do
      after :create do |instance|
        10.times do
          instance.contributions << create(:contribution, amount: Faker::Commerce.price, jar_id: instance.id, state: 'completed')
        end
      end
    end

    trait :with_abuses do
      after :create do |instance|
        10.times do
          instance.reported_abuses << create(:abuse, resource_id: instance.id, resource_type: 'Jar')
        end
      end
    end

    trait :with_guests do
      guests { create_list(:user, 3) }
    end

    trait :with_description do
      description { Faker::Lorem.paragraph }
    end

    trait :with_upper_bound do
      upper_bound { Faker::Commerce.price }
    end

    trait :public do
      visible { true }
    end

    trait :open do
    end

    trait :closed do
      after :create do |model|
        model.update_columns(end_at: 3.days.ago, created_at: 10.days.ago)
      end
    end

    trait :ended do
      after :create do |model|
        model.update_column(:end_at, 8.days.ago)
      end
    end

    trait :visible do
      visible { true }
    end
  end
end
