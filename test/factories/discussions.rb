FactoryGirl.define do
  factory :discussion do
    user
    discussion_category
    body Faker::Lorem.sentence(20)
    title Faker::Lorem.sentence(4)
  end
end