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
#

require 'test_helper'

class DiscussionTest < ActiveSupport::TestCase
  test "raises validation warning if no body is added" do
    build(:discussion, body: nil).invalid?(:discussion).must_equal true
  end

  test "raises validation warning if no title is added" do
    build(:discussion, title: nil).invalid?(:discussion).must_equal true
  end

  test "raises validation warning if no discussion_category_id is added" do
    build(:discussion, discussion_category_id: nil).invalid?(:discussion).must_equal true
  end

  test "updates the discussion comments counter cache with comment creation" do
    discussion = create(:discussion)
    assert_equal 0, discussion.reload.discussion_comments_count
    comment = create(:discussion_comment, discussion: discussion)
    assert_equal 1, discussion.reload.discussion_comments_count
  end

  test "updates the discussion comments counter cache with comment deletion" do
    discussion = create(:discussion)
    comment = create(:discussion_comment, discussion: discussion)
    assert_equal 1, discussion.reload.discussion_comments_count
    comment.destroy
    assert_equal 0, discussion.reload.discussion_comments_count
  end

  test "deletes all comments when deleting a discussion" do
    discussion = create(:discussion)
    comment = create(:discussion_comment, discussion: discussion)
    comment = create(:discussion_comment, discussion: discussion)
    assert_equal 2, discussion.reload.discussion_comments_count
    discussion.destroy
    assert_equal 0, DiscussionComment.count
  end

  test "visible scope" do
    discussion_one = create(:discussion)
    discussion_two = create(:discussion)
    discussion_three = create(:discussion, hidden: true)
    assert_equal [discussion_one, discussion_two], Discussion.visible
  end

  test "recency scope" do
    discussion_one = create(:discussion)
    discussion_two = create(:discussion)
    discussion_three = create(:discussion, hidden: true)
    assert_equal [discussion_three, discussion_two, discussion_one], Discussion.by_recency
  end
end
