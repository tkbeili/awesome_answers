FactoryGirl.define do
  factory :question do
    title Faker::Lorem.sentence
    body Faker::Lorem.paragraph
    hit_count 0
    like_count 0
  end
end
