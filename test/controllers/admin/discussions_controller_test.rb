require 'test_helper'

class Admin::DiscussionsControllerTest < ActionController::TestCase
  def setup
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

  test "GET index assigns the discussions by recency" do
    discussion_one = create(:discussion)
    discussion_two = create(:discussion)
    get :index
    assert_equal [discussion_two, discussion_one], assigns(:discussions)
  end

  test "GET edit responds successfully" do
    discussion = create(:discussion, id: 23)
    get :edit, id: 23
    assert_response :success, @response.body
  end

  test "GET edit assigns the discussion" do
    discussion = create(:discussion, id: 23)
    get :edit, id: 23
    assert_equal discussion, assigns(:discussion)
  end

  test "GET edit assigns the categories" do
    category = create(:discussion_category)
    discussion = create(:discussion, id: 23, discussion_category: category)
    get :edit, id: 23
    assert_equal [category], assigns(:categories)
  end

  test "PUT update assigns the discussion" do
    discussion = create(:discussion, id: 5)
    put :update, id: 5, discussion: { body: 'An updated body' }
    assert_equal discussion, assigns(:discussion)
  end

  test "PUT update will update the discussion discussion" do
    category   = create(:discussion_category)
    discussion = create(:discussion, id: 5, discussion_category: category, user: User.last)
    put :update, id: 5, discussion: { body: 'An updated body' }
    assert_equal discussion.reload.body, 'An updated body'
  end

  test "PUT update will redirect to the admin discussions index updating successfully" do
    category   = create(:discussion_category)
    discussion = create(:discussion, id: 5, discussion_category: category, user: User.last)
    put :update, id: 5, discussion: { body: 'An updated body' }
    assert_redirected_to admin_discussions_path
  end

  test "PUT update will render the edit page if not updated successfully" do
    category   = create(:discussion_category)
    discussion = create(:discussion, id: 5, discussion_category: category)
    put :update, id: 5, discussion: { body: '' }
    assert_template 'edit'
  end

  test "PUT update will assign the categories after not updating successfully" do
    category   = create(:discussion_category)
    discussion = create(:discussion, id: 5, discussion_category: category)
    put :update, id: 5, discussion: { body: '' }
    assert_equal [category], assigns(:categories)
  end

  test "DELETE destroy assigns the discussion" do
    discussion = create(:discussion, id: 301)
    delete :destroy, id: 301
    assert_equal discussion, assigns(:discussion)
  end

  test "DELETE destroy will destroy a guideline" do
    create(:discussion, id: 302)
    assert_difference 'Discussion.count', -1 do
      delete :destroy, id: 302
    end
  end

  test "DELETE destroy redirects to the guidelines index" do
    create(:discussion, id: 303)
    delete :destroy, id: 303
    assert_redirected_to admin_discussions_path
  end
end