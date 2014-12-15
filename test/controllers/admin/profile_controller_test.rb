require 'test_helper'

class Admin::ProfileControllerTest < ActionController::TestCase
  def setup
    create(:app_settings)
    create(:user, username: 'Guest')
    @admin = create(:admin)
    sign_in(:admin, @admin)
  end

  test "GET edit responds successfully" do
    get :edit
    assert_response :success, @response.body
  end

   test "GET edit renders the correct template" do
    get :edit
    assert_template 'edit'
  end

  test "PATCH update will update the admin's details" do
    patch :update, admin: { name: 'New Name', password: 'super secret', password_confirmation: 'super secret' }
    assert_equal @admin.reload.name, 'New Name'
  end

  test "PATCH update will redirect to the admin index after updating successfully" do
    patch :update, admin: { name: 'New Name' }
    assert_redirected_to admin_path
  end
end