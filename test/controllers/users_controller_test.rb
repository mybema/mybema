require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    create(:app_settings)
    create(:user, username: 'Guest')
    @user = create(:user, username: "joel")
  end

  test "GET profile responds successfully" do
    get :profile, username: 'joel'
    assert_response :success, @response.body
  end

  test "GET profile assigns the user" do
    get :profile, username: 'joel'
    assert_equal @user, assigns(:user)
  end

  test "GET profile assigns the user's discussions" do
    discussion = create(:discussion, user: @user)
    get :profile, username: 'joel'
    assert_equal [discussion], assigns(:user_discussions)
  end

  test "GET profile assigns the user's comments" do
    comment = create(:discussion_comment, user: @user)
    get :profile, username: 'joel'
    assert_equal [comment], assigns(:user_responses)
  end

  test "GET profile redirects if a user is not found" do
    get :profile, username: 'joelly'
    assert_redirected_to root_path
  end

  test "GET profile redirects to root if the user is the guest user" do
    get :profile, username: 'Guest'
    assert_redirected_to root_path
  end

  test "GET edit_profile responds successfully when signed in" do
    sign_in(:user, @user)
    get :edit_profile
    assert_response :success, @response.body
  end

  test "GET edit_profile redirects guest users to the root path" do
    get :edit_profile
    assert_redirected_to root_path
  end

  test "PATCH update_profile redirects to the profile path successfully when signed in" do
    sign_in(:user, @user)
    patch :update_profile, user: { email: 'fake@email.com' }
    assert_redirected_to profile_path
  end

  test "PATCH update_profile redirects guest user to root path" do
    patch :update_profile, user: { username: 'Guest' }
    assert_redirected_to root_path
  end
end