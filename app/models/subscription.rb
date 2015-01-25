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

class Subscription < ActiveRecord::Base
  belongs_to :discussion
  belongs_to :user

  after_create :generate_email_token

  private

  def generate_email_token
    update_attributes(email_token: SecureRandom.hex(24))
  end
end
