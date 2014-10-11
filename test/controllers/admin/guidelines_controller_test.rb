require 'test_helper'

class Admin::GuidelinesControllerTest < ActionController::TestCase
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

  test "GET index assigns all of the guidelines in the correct order" do
    guideline_one = create(:guideline, name: 'one')
    guideline_two = create(:guideline, name: 'two')
    get :index
    assert_equal [guideline_two, guideline_one], assigns(:guidelines)
  end

  test "GET new responds successfully" do
    get :new
    assert_response :success, @response.body
  end

   test "GET new renders the correct template" do
    get :new
    assert_template 'new'
  end

  test "GET new assigns a new guideline" do
    get :new
    assigns(:guideline).must_be_kind_of Guideline
  end

  test "DELETE destroy will destroy a guideline" do
    create(:guideline, name: 'name', id: 101)
    assert_difference 'Guideline.count', -1 do
      delete :destroy, id: 101
    end
  end

  test "DELETE destroy redirects to the guidelines index" do
    create(:guideline, name: 'name', id: 101)
    delete :destroy, id: 101
    assert_redirected_to guidelines_path
  end

  test "POST create will create a guideline" do
    assert_difference 'Guideline.count', 1 do
      post :create, guideline: { name: 'sweet guideline' }
    end
  end

  test "POST create redirects to the guidelines index if successfully created" do
    post :create, guideline: { name: 'sweet guideline' }
    assert_redirected_to guidelines_path
  end

  test "POST create will not create a guideline if it is invalid" do
    assert_difference 'Guideline.count', 0 do
      post :create, guideline: { name: ''}
    end
  end

  test "POST create will render the new template if create is not successful" do
    post :create, guideline: { name: ''}
    assert_template 'new'
  end
end