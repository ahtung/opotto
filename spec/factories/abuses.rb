FactoryGirl.define do
  factory :abuse do
    email { Faker::Internet.email }
    title { Faker::Book.title }
    referer { Faker::Internet.url }
    description "MyString"
    confirmed { [true,false].sample }
    resource_id 1
    resource_type "MyString"
    created_at { Time.zone.now }
  end
end
