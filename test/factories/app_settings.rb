# == Schema Information
#
# Table name: app_settings
#
#  id                  :integer          not null, primary key
#  all_articles_img    :string(255)
#  all_discussions_img :string(255)
#  join_community_img  :string(255)
#  new_discussion_img  :string(255)
#  logo                :string(255)
#  hero_message        :text
#  created_at          :datetime
#  updated_at          :datetime
#  seed_level          :integer          default(0)
#  guest_posting       :boolean          default(TRUE)
#  ga_code             :string(255)
#

FactoryGirl.define do
  factory :app_settings do
    hero_message { Faker::Lorem.sentence(10) }
  end
end
