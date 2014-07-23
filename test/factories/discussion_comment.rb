FactoryGirl.define do
  factory :discussion_comment do
    user
    discussion
    body Faker::Lorem.sentence(8)
  end
end