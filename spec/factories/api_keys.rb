# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :api_key do
    association :user, factory: :user
  end
end