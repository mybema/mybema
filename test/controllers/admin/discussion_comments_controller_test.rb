require 'test_helper'

class Admin::DiscussionCommentsControllerTest < ActionController::TestCase
  def setup
    admin = create(:admin)
    sign_in(:admin, admin)
  end

  test "GET index responds successfully" do
    get :index
    assert_response :success, @response.body
  end

   test "GET index renders the correct template" do
    get :index
    assert_template 'index'
  end

  test "GET index assigns all of the comments by recency" do
    comment_one = create(:discussion_comment)
    comment_two = create(:discussion_comment)
    get :index
    assert_equal [comment_two, comment_one], assigns(:comments)
  end

  test "GET edit responds successfully" do
    create(:discussion_comment, id: 23)
    get :edit, id: 23
    assert_response :success, @response.body
  end

  test "GET edit assigns the comment" do
    comment = create(:discussion_comment, id: 23)
    get :edit, id: 23
    assert_equal comment, assigns(:comment)
  end

  test "PUT update assigns the comment" do
    comment = create(:discussion_comment, id: 5)
    put :update, id: 5, discussion_comment: { body: 'An updated comment' }
    assert_equal comment, assigns(:comment)
  end

  test "PUT update updates the comment" do
    comment = create(:discussion_comment, id: 24)
    put :update, id: 24, discussion_comment: { body: 'A newly updated comment' }
    assert_equal comment.reload.body, 'A newly updated comment'
  end

  test "PUT update will redirect to the admin comments index updating successfully" do
    create(:discussion_comment, id: 75)
    put :update, id: 75, discussion_comment: { body: 'An updated comment' }
    assert_redirected_to admin_comments_path
  end

  test "PUT update will render the edit page if not updated successfully" do
    create(:discussion_comment, id: 79)
    put :update, id: 79, discussion_comment: { body: '' }
    assert_template 'edit'
  end

  test "PUT toggle_visibility assigns the comment" do
    comment = create(:discussion_comment, id: 76)
    put :toggle_visibility, id: 76
    assert_equal comment, assigns(:comment)
  end

  test "PUT toggle_visibility redirects to the edit page" do
    create(:discussion_comment, id: 65)
    put :toggle_visibility, id: 65
    assert_redirected_to edit_admin_comment_path
  end

  test "PUT toggle_visibility toggles the comment's visibility" do
    create(:discussion_comment, id: 57, hidden: true)
    put :toggle_visibility, id: 57
    assert_equal DiscussionComment.find(57).hidden, false
  end

  test "DELETE destroy assigns the comment" do
    comment = create(:discussion_comment, id: 301)
    delete :destroy, id: 301
    assert_equal comment, assigns(:comment)
  end

  test "DELETE destroy will destroy the comment" do
    create(:discussion_comment, id: 302)
    assert_difference 'DiscussionComment.count', -1 do
      delete :destroy, id: 302
    end
  end

  test "DELETE destroy redirects to the comment index" do
    create(:discussion_comment, id: 303)
    delete :destroy, id: 303
    assert_redirected_to admin_comments_path
  end
end