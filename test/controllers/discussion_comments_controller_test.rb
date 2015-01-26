require 'test_helper'
require 'sidekiq/testing'

Sidekiq::Testing.inline!

class DiscussionCommentsControllerTest < ActionController::TestCase
  def setup
    create(:user, username: 'Guest')
    create(:app_settings)
    create(:admin)
  end

  test "POST create will create a new comment as a guest if guest posting is enabled" do
    discussion = create(:discussion, id: 4)
    post :create, discussion_comment: { body: 'The comment body', user_id: 5, discussion_id: 4 }
    assert_equal DiscussionComment.last.body, 'The comment body'
  end

  test "POST create will create a new comment as admin when guest posting is disabled" do
    AppSettings.first.update_attributes(guest_posting: false)
    sign_in(:admin, create(:admin))
    discussion = create(:discussion, id: 4)
    post :create, discussion_comment: { body: 'The comment body', user_id: 5, discussion_id: 4 }
    assert_equal DiscussionComment.last.body, 'The comment body'
  end

  test "POST create will not create a new comment as guest if guest posting is disabled" do
    AppSettings.first.update_attributes(guest_posting: false)
    discussion = create(:discussion, id: 4)
    post :create, discussion_comment: { body: 'The comment body', user_id: 5, discussion_id: 4 }
    assert_equal DiscussionComment.count, 0
  end

  test "POST create redirects to the discussion when created successfully" do
    discussion = create(:discussion, id: 4)
    post :create, discussion_comment: { body: 'The body', title: 'slug', user_id: 5, discussion_id: 4 }
    assert_redirected_to discussion_path(discussion.slug)
  end
end