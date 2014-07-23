FactoryGirl.define do
  factory :discussion_category do
    name Faker::Lorem.sentence(4)
    description Faker::Lorem.sentence(8)
  end
end