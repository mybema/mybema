# == Schema Information
#
# Table name: sections
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  articles_count :integer          default("0")
#  created_at     :datetime
#  updated_at     :datetime
#

FactoryGirl.define do
  factory :section do
    title { Faker::Lorem.sentence(4) }
  end
end
