# == Schema Information
#
# Table name: hero_messages
#
#  id         :integer          not null, primary key
#  message    :text
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :app_settings do
    hero_message { Faker::Lorem.sentence(10) }
  end
end
