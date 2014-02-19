FactoryGirl.define do
  factory :question do
    title Faker::Lorem.sentence
    body Faker::Lorem.paragraph
    like_count 0
  end
end
