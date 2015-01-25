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

require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  test "can belong to a discussion" do
    subscription = Subscription.new
    subscription.must_respond_to :discussion
  end

  test "can belong to a user" do
    subscription = Subscription.new
    subscription.must_respond_to :user
  end

  test "generates an email token after creation" do
    subscription = create(:subscription)
    refute_equal subscription.email_token, nil
  end
end
