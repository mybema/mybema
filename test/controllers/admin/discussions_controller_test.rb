require 'test_helper'

class Admin::DiscussionsControllerTest < ActionController::TestCase
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

  test "GET index assigns the discussions by recency" do
    discussion_one = create(:discussion)
    discussion_two = create(:discussion)
    get :index
    assert_equal [discussion_two, discussion_one], assigns(:discussions)
  end
end