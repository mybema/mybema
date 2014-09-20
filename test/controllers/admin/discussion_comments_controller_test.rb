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
end