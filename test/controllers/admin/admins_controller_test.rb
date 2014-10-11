require 'test_helper'

class Admin::AdminsControllerTest < ActionController::TestCase
  def setup
    @admin = create(:admin)
    create(:user, username: 'Guest')
    sign_in(:admin, @admin)
  end

  test "GET index responds successfully" do
    get :index
    assert_response :success, @response.body
  end

   test "GET index renders the correct template" do
    get :index
    assert_template 'index'
  end

  test "GET index assigns all of the admins" do
    get :index
    assert_equal [@admin], assigns(:admins)
  end

  test "GET new responds successfully" do
    get :new
    assert_response :success, @response.body
  end

   test "GET new renders the correct template" do
    get :new
    assert_template 'new'
  end

  test "GET new assigns a new admin" do
    get :new
    assigns(:admin).must_be_kind_of Admin
  end

  test "POST create will create a new admin" do
    assert_difference 'Admin.count', 1 do
      post :create, admin: { name: 'Bob', email: 'bob@fake.com' }
    end
  end

  test "POST create will redirect to admins_path" do
    post :create, admin: { name: 'Bob', email: 'bob@fake.com' }
    assert_redirected_to admins_path
  end
end