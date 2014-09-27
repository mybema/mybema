# == Schema Information
#
# Table name: discussion_comments
#
#  id            :integer          not null, primary key
#  body          :text
#  hidden        :boolean          default(FALSE)
#  discussion_id :integer
#  user_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#  admin_id      :integer
#

require 'test_helper'

class DiscussionCommentTest < ActiveSupport::TestCase
  test "raises validation warning if no body is added" do
    build(:discussion_comment, body: nil).invalid?(:discussion_comment).must_equal true
  end

  test 'visible scope' do
    comment_one = create(:discussion_comment)
    comment_two = create(:discussion_comment)
    comment_three = create(:discussion_comment, hidden: true)
    assert_equal [comment_one, comment_two], DiscussionComment.visible
  end

  test '#username' do
    create(:admin, id: 1, name: 'AdminDude')
    comment = DiscussionComment.new(admin_id: 1)
    assert_equal 'AdminDude', comment.username

    create(:user, id: 1, username: 'John')
    comment = DiscussionComment.new(user_id: 1)
    assert_equal 'John', comment.username

    comment = DiscussionComment.new
    assert_equal 'Guest', comment.username
  end
end