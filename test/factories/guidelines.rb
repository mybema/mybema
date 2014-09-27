# == Schema Information
#
# Table name: guidelines
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :guideline do
    name Faker::Lorem.sentence(4)
  end
end
