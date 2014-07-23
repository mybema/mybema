require 'test_helper'

class DiscussionsControllerTest < ActionController::TestCase
  test "GET index responds successfully" do
    create(:discussion)
    get :index
    assert_response :success, @response.body
  end

  test "GET index assigns all visible discussions" do
    first_discussion  = create(:discussion)
    second_discussion = create(:discussion)
    third_discussion  = create(:discussion, hidden: true)
    get :index
    assert_equal [first_discussion, second_discussion], assigns(:discussions)
  end

  test "GET index does not assign category without discussion_category_id param" do
    create(:discussion)
    get :index
    assert_equal nil, assigns(:category)
  end

  test "GET index assigns category from discussion_category_id param" do
    category = create(:discussion_category)
    create(:discussion, discussion_category: category)
    get :index, discussion_category_id: category.id
    assert_equal category, assigns(:category)
  end

  test "GET index assigns discussions from a category filtered by discussion_category_id param" do
    category = create(:discussion_category)
    first_discussion  = create(:discussion, discussion_category: category)
    second_discussion = create(:discussion)
    get :index, discussion_category_id: category.id
    assert_equal [first_discussion], assigns(:discussions)
  end
end