# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }

    trait :with_jars do
      jars { create_list(:jar, 5) }
    end

    trait :with_invitations do
      after :create do |instance|
        instance.invitations = create_list(:invitation, 10)
      end
    end

    trait :with_name do
      name { Faker::Name.name }
    end

    trait :registered do
      last_sign_in_at { Faker::Date.between(2.days.ago, Date.today) }
    end

    trait :with_contributions do
      after :create do |instance|
        instance.contributions = create_list(:contribution, 10, amount: Faker::Commerce.price)
      end
    end

    trait :with_paypal do
      email 'us-personal@gmail.com'
      paypal_member true
    end

    trait :dunya do
      email 'dunyakirkali@gmail.com'
      paypal_member true
      after :create do |instance|
        onur = User.where(email: 'onurkucukkece@gmail.com').first || create(:user, :onur)
        us = User.where(email: 'us-personal@gmail.com').first || create(:user, :with_paypal)
        instance.contacts << onur
        instance.contacts << us
      end
    end

    trait :onur do
      email 'onurkucukkece@gmail.com'
      paypal_member true
      after :create do |instance|
        dunya = User.where(email: 'dunyakirkali@gmail.com').first || create(:user, :dunya)
        us = User.where(email: 'us-personal@gmail.com').first || create(:user, :with_paypal)
        instance.contacts << dunya
        instance.contacts << us
      end
    end
  end
end
