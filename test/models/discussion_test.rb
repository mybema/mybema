require 'test_helper'

class DiscussionTest < ActiveSupport::TestCase
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
end