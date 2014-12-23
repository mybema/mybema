require 'test_helper'

class Admin::AppSettingsControllerTest < ActionController::TestCase
  def setup
    @app_settings = create(:app_settings, id: 1)
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

  test "patch update will update the app settings" do
    patch :update, id: 1, app_settings: { hero_message: 'An updated hero_message' }
    assert_equal @app_settings.reload.hero_message, 'An updated hero_message'
  end

  test "patch update will redirect to the settings_path after updating successfully" do
    patch :update, id: 1, app_settings: { hero_message: 'An updated hero_message' }
    assert_redirected_to app_settings_path
  end

  test "patch toggle_guest_posting will update the app settings" do
    patch :toggle_guest_posting, app_settings: { commit: 'enable guest posting' }
    assert_equal @app_settings.reload.guest_posting, false
  end

  test "patch toggle_guest_posting will redirect to the settings_path after updating successfully" do
    patch :toggle_guest_posting, app_settings: { commit: 'enable guest posting' }
    assert_redirected_to app_settings_path
  end
end