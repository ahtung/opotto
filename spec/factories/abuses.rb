FactoryGirl.define do
  factory :abuse do
    email { Faker::Internet.email }
    title { Faker::Book.title }
    referer { Faker::Internet.url }
    description { Faker::Lorem.paragraph }
    confirmed { false }
    resource_id 1
    resource_type 'Jar'
    created_at { Time.zone.now }
  end
end
