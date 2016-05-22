# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Number.number(8) }
    admin 'false'
    avatar { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/avatar.jpg'), 'image/jpg') }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    trait :with_pot do
      pots { create_list(:pot, 1, :open) }
    end

    trait :with_closed_pots do
      pots { create_list(:pot, 1, :closed) }
    end

    trait :with_invitations do
      after :create do |instance|
        instance.invitations = create_list(:invitation, 2)
      end
    end

    trait :registered do
      last_sign_in_at { Faker::Date.between(2.days.ago, Time.zone.now) }
    end

    trait :with_contribution do
      after :create do |instance|
        instance.contributions = create_list(:contribution, 2, amount: Faker::Commerce.price)
      end
    end

    trait :with_paypal do
      email 'us-personal@gmail.com'
      paypal_member true
    end

    trait :admin do
      admin 'true'
    end
  end
end
