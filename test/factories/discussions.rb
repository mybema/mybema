# == Schema Information
#
# Table name: discussions
#
#  id                        :integer          not null, primary key
#  body                      :text
#  title                     :string(255)
#  hidden                    :boolean          default(FALSE)
#  discussion_category_id    :integer
#  user_id                   :integer
#  discussion_comments_count :integer          default(0)
#  created_at                :datetime
#  updated_at                :datetime
#  guest_id                  :string(255)
#

FactoryGirl.define do
  factory :discussion do
    user
    discussion_category
    body Faker::Lorem.sentence(20)
    title Faker::Lorem.sentence(4)
  end
end
