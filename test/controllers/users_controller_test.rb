require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    create(:app_settings)
    create(:user, username: 'Guest')
    @user = create(:user)
  end

  test "GET profile responds successfully when signed in" do
    sign_in(:user, @user)
    get :profile
    assert_response :success, @response.body
  end

  test "GET profile redirects guest users to the root path" do
    get :profile
    assert_redirected_to root_path
  end

  test "PATCH update_profile redirects to the root path successfully when signed in" do
    sign_in(:user, @user)
    patch :update_profile, user: { email: 'fake@email.com' }
    assert_redirected_to profile_path
  end

  test "PATCH update_profile redirects guest user to root path" do
    patch :update_profile, user: { username: 'Guest' }
    assert_redirected_to root_path
  end
end