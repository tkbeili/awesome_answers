FactoryGirl.define do
  
  factory :like do
    association :likeable
    association :user
  end

end