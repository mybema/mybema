require 'test_helper'

class DiscussionCommentsControllerTest < ActionController::TestCase
  def setup
    create(:user, username: 'Guest')
  end

  test "POST create will create a new comment" do
    discussion = create(:discussion, id: 4)
    post :create, discussion_comment: { body: 'The comment body', user_id: 5, discussion_id: 4 }
    assert_equal DiscussionComment.last.body, 'The comment body'
  end

  test "POST create redirects to the discussion" do
    discussion = create(:discussion, id: 4)
    post :create, discussion_comment: { body: 'The body', user_id: 5, discussion_id: 4 }
    assert_redirected_to discussion_path(4)
  end
end