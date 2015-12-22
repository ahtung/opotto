FactoryGirl.define do
  factory :invitation do
    association :jar, strategy: :build
    association :user, strategy: :build
  end
end
