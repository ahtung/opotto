FactoryGirl.define do
  factory :jar do
    name { Faker::Name.name }
    owner { create(:user) }

    trait :with_contributors do
      contributors { create_list(:user, 3) }
    end

    trait :with_contributions do
      contributions { create_list(:contribution, 3) }
    end
  end
end
