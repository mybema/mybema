# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  email                  :string(255)
#  username               :string(255)
#  ip_address             :string(255)
#  guid                   :string(255)
#  banned                 :boolean          default(FALSE)
#  created_at             :datetime
#  updated_at             :datetime
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "nullifies foreign key for discussion when user is deleted" do
    user = create(:user)
    discussion = create(:discussion, user: user)
    user.destroy
    assert_equal nil, discussion.reload.user_id
  end

  test "nullifies foreign key for discussion comment when user is deleted" do
    user = create(:user)
    comment = create(:discussion_comment, user: user)
    user.destroy
    assert_equal nil, comment.reload.user_id
  end

  test 'guest?' do
    user = User.new(username: 'Bob')
    assert_equal false, user.guest?
    guest = User.new(username: 'Guest')
    assert_equal true, guest.guest?
  end

  test '#username' do
    user = User.new(username: 'Mike')
    assert_equal 'Mike', user.username

    user = User.new
    assert_equal 'Guest', user.username
  end

  test '#discussion_count' do
    user = create(:user)
    create(:discussion, user: user)
    assert_equal user.discussion_count, 1
  end

  test '#comment_count' do
    user = create(:user)
    discussion = create(:discussion)
    3.times { create(:discussion_comment, discussion: discussion, user: user) }
    assert_equal user.comment_count, 3
  end
end