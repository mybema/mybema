require 'test_helper'

class DiscussionsControllerTest < ActionController::TestCase
  def setup
    create(:user, username: 'Guest')
  end

  test "GET index responds successfully" do
    create(:discussion)
    get :index
    assert_response :success, @response.body
  end

  test "GET index assigns all categories" do
    category_one = create(:discussion_category)
    category_two = create(:discussion_category)
    get :index
    assert_equal [category_one, category_two], assigns(:categories)
  end

  test "GET index assigns all visible discussions" do
    first_discussion  = create(:discussion)
    second_discussion = create(:discussion)
    third_discussion  = create(:discussion, hidden: true)
    get :index
    assert_equal [second_discussion, first_discussion], assigns(:discussions)
  end

  test "GET index does not assign category without the category param" do
    create(:discussion)
    get :index
    assert_equal nil, assigns(:category)
  end

  test "GET index assigns category from the category param" do
    category = create(:discussion_category)
    create(:discussion, discussion_category: category)
    get :index, category: category.slug
    assert_equal category, assigns(:category)
  end

  test "GET index assigns discussions from a category filtered by the category param" do
    category = create(:discussion_category)
    first_discussion  = create(:discussion, discussion_category: category)
    second_discussion = create(:discussion)
    get :index, category: category.slug
    assert_equal [first_discussion], assigns(:discussions)
  end

  test "GET show assigns the discussion" do
    discussion = create(:discussion)
    get :show, id: discussion.id
    assert_equal discussion, assigns(:discussion)
  end

  test "GET show assigns all categories" do
    category_one = create(:discussion_category)
    category_two = create(:discussion_category)
    discussion   = create(:discussion, discussion_category: category_one)
    get :show, id: discussion.id
    assert_equal [category_two, category_one], assigns(:categories)
  end

  test "GET new assigns all categories" do
    category = create(:discussion_category)
    get :new
    assert_equal [category], assigns(:categories)
  end

  test "GET new assigns a new discussion" do
    category = create(:discussion_category)
    get :new
    assert_not_nil assigns(:discussion)
  end

  test "GET edit assigns all categories" do
    category = create(:discussion_category)
    discussion = create(:discussion, discussion_category: category)
    get :edit, id: discussion.id
    assert_equal [category], assigns(:categories)
  end

  test "GET edit assigns the discussion" do
    category = create(:discussion_category)
    discussion = create(:discussion, discussion_category: category)
    get :edit, id: discussion.id
    assert_equal discussion, assigns(:discussion)
  end

  test "POST create will create a new discussion" do
    category = create(:discussion_category)
    post :create, discussion: { body: 'The body', title: 'The title', user_id: 5, discussion_category_id: 1 }
    assert_equal 'The title', Discussion.last.title
  end

  test "POST create will render 'new' template if discussion not created successfully" do
    category = create(:discussion_category)
    post :create, discussion: { user_id: 5, discussion_category_id: 1 }
    assert_template 'new'
  end

  test "POST create will redirect to discussion after creation" do
    category = create(:discussion_category)
    post :create, discussion: { body: 'The body', title: 'The title', user_id: 5, discussion_category_id: 1 }
    assert_redirected_to discussion_path(assigns(:discussion))
  end

  test "PUT update will update a user's own discussion" do
    category   = create(:discussion_category)
    discussion = create(:discussion, id: 5, discussion_category: category, user: User.last)
    put :update, id: 5, discussion: { body: 'An updated body' }
    assert_equal discussion.reload.body, 'An updated body'
  end

  test "PUT update will not update another user's discussion" do
    category   = create(:discussion_category)
    discussion = create(:discussion, id: 5, discussion_category: category)
    put :update, id: 5, discussion: { body: 'An updated body' }
    refute_equal discussion.reload.body, 'An updated body'
  end

  test "PUT update will redirect to discussion after updating successfully" do
    category   = create(:discussion_category)
    discussion = create(:discussion, id: 5, discussion_category: category, user: User.last)
    put :update, id: 5, discussion: { body: 'An updated body' }
    assert_redirected_to discussion_path(discussion)
  end

  test "PUT update will render the edit page if not updated successfully" do
    category   = create(:discussion_category)
    discussion = create(:discussion, id: 5, discussion_category: category)
    put :update, id: 5, discussion: { body: 'An updated body' }
    assert_template 'edit'
  end
end