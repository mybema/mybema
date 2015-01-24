# == Schema Information
#
# Table name: discussion_categories
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  slug              :string(255)
#  description       :text
#  discussions_count :integer          default("0")
#  created_at        :datetime
#  updated_at        :datetime
#

FactoryGirl.define do
  factory :discussion_category do
    name Faker::Lorem.sentence(4)
    description Faker::Lorem.sentence(8)
  end
end
