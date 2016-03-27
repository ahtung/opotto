FactoryGirl.define do
  factory :invitation do
    association :pot, strategy: :build
    association :user, strategy: :build
  end
end
