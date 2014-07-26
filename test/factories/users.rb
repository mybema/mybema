FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    sequence(:email) { |n| Faker::Internet.email + "#{n}" }
    password Faker::Internet.password
    username Faker::Internet.user_name
    ip_address Faker::Internet.ip_v4_address
  end
end