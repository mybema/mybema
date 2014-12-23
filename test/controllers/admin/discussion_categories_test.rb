require 'test_helper'

class Admin::DiscussionCategoriesControllerTest < ActionController::TestCase
  def setup
    create(:app_settings)
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

  test "GET index assigns the categories by recency" do
    category_one = create(:discussion_category)
    category_two = create(:discussion_category)
    get :index
    assert_equal [category_one, category_two], assigns(:categories)
  end

  test "GET edit responds successfully" do
    create(:discussion_category, id: 23)
    get :edit, id: 23
    assert_response :success, @response.body
  end

  test "GET edit assigns the category" do
    category = create(:discussion_category, id: 23)
    get :edit, id: 23
    assert_equal category, assigns(:category)
  end

  test "PUT update assigns the category" do
    category = create(:discussion_category, id: 5)
    put :update, id: 5, discussion_category: { name: 'An updated name' }
    assert_equal category, assigns(:category)
  end

  test "PUT update will update the category" do
    category = create(:discussion_category, id: 5)
    put :update, id: 5, discussion_category: { name: 'An updated name' }
    assert_equal category.reload.name, 'An updated name'
  end

  test "PUT update will redirect to the admin discussion categories index updating successfully" do
    category = create(:discussion_category, id: 5)
    put :update, id: 5, discussion_category: { name: 'An updated name' }
    assert_redirected_to admin_discussion_categories_path
  end

  test "DELETE destroy assigns the category" do
    category = create(:discussion_category, id: 301)
    delete :destroy, id: 301
    assert_equal category, assigns(:category)
  end

  test "DELETE destroy will destroy a category" do
    create(:discussion_category, id: 302)
    assert_difference 'DiscussionCategory.count', -1 do
      delete :destroy, id: 302
    end
  end

  test "DELETE destroy redirects to the category index" do
    create(:discussion_category, id: 303)
    delete :destroy, id: 303
    assert_redirected_to admin_discussion_categories_path
  end
end