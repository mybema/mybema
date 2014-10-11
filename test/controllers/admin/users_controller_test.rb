require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase
  def setup
    create(:user, username: 'Guest')
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
    user_one = create(:user)
    user_two = create(:user)
    get :index
    assert_equal [user_one, user_two], assigns(:users)
  end
end