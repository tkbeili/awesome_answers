FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "some_name#{n}@gmail.com"}
    password Faker::Internet.password
  end
end