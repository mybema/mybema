# == Schema Information
#
# Table name: hero_messages
#
#  id         :integer          not null, primary key
#  message    :text
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class HeroMessageTest < ActiveSupport::TestCase
  test "raises validation warning if no message is added" do
    HeroMessage.new.invalid?(:message).must_equal true
  end
end