# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :jar do
    owner_id 1
    name { Faker::Name.name }
  end
end
