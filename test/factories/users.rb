FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    email Faker::Internet.email
    username Faker::Internet.user_name
    ip_address Faker::Internet.ip_v4_address
  end
end