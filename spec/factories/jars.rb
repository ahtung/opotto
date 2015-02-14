FactoryGirl.define do
  factory :jar do
    name { Faker::Name.name }

    trait :with_contributors do
      contributors { create_list(:user, 3) }
    end

    trait :with_contributions do
      contributions { create_list(:contribution, 3) }
    end

    trait :with_owner do
      owner { create(:user) }
    end
  end
end
