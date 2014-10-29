require 'test_helper'

class Admin::SettingsControllerTest < ActionController::TestCase
  def setup
    @hero_message = create(:hero_message)
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

  test "GET index assigns the hero message" do
    get :index
    assert_equal @hero_message, assigns(:hero_message)
  end
end