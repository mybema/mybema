# == Schema Information
#
# Table name: subscriptions
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  discussion_id :integer
#  guest_email   :string
#  subscribed    :boolean          default("true")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  email_token   :string
#

FactoryGirl.define do
  factory :subscription do
  end
end
