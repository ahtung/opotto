# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Number.number(8) }
    admin 'false'
    avatar { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/avatar.jpg'), 'image/jpg') }
    first_name { Faker::Lorem.word }
    last_name { Faker::Lorem.word }

    trait :with_pot do
      after :create do |instance|
        instance.pots << create(:pot, :open, owner: instance)
      end
    end

    trait :with_pots do
      after :create do |instance|
        instance.pots = create_list(:pot, 2, :open, owner: instance)
      end
    end

    trait :with_closed_pots do
      pots { create_list(:pot, 2, :closed) }
    end

    trait :with_invitations do
      after :create do |instance|
        instance.invitations = create_list(:invitation, 2)
      end
    end

    trait :registered do
      last_sign_in_at { Faker::Date.between(2.days.ago, Time.zone.now) }
    end

    trait :with_contributions do
      after :create do |instance|
        instance.contributions = create_list(:contribution, 2, :completed, amount: Faker::Commerce.price, user: instance)
      end
    end

    trait :admin do
      admin 'true'
    end
  end
end
