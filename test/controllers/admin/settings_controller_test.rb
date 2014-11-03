require 'test_helper'

class Admin::SettingsControllerTest < ActionController::TestCase
  def setup
    @hero_message = create(:app_settings).hero_message
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
end