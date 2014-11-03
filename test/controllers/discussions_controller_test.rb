require 'test_helper'

class DiscussionsControllerTest < ActionController::TestCase
  def setup
    @guest = create(:user, username: 'Guest')
    create(:app_settings)
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

  test "GET show does not redirect if discussion is visible" do
    category_one = create(:discussion_category)
    category_two = create(:discussion_category)
    discussion   = create(:discussion, discussion_category: category_one)
    get :show, id: discussion.id
    assert_response :success, @response.body
  end

  test "GET show does not redirects if discussion is hidden and user is an admin" do
    discussion = create(:discussion, hidden: true)
    admin = create(:admin)
    sign_in(:admin, admin)
    get :show, id: discussion.id
    assert_response :success, @response.body
  end

  test "GET show redirects if discussion is hidden and user is not an admin" do
    discussion   = create(:discussion, hidden: true)
    get :show, id: discussion.id
    assert_redirected_to discussions_path
  end

  test "GET show assigns the comments" do
    discussion  = create(:discussion)
    comment_one = create(:discussion_comment, discussion: discussion)
    comment_two = create(:discussion_comment, discussion: discussion)
    get :show, id: discussion.id
    assert_equal [comment_one, comment_two], assigns(:comments)
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

  test "GET edit assigns the guidelines" do
    guideline = create(:guideline)
    discussion = create(:discussion)
    get :edit, id: discussion.id
    assert_equal [guideline], assigns(:guidelines)
  end

  test "GET edit assigns the discussion if the discussion guid matches the guest cookie" do
    category = create(:discussion_category)
    discussion = create(:discussion, discussion_category: category, user: @guest, guest_id: 'same')
    @request.cookies['mybema_guest_id'] = 'same'
    get :edit, id: discussion.id
    assert_equal discussion, assigns(:discussion)
  end

  test "GET edit assigns the discussion to the non-guest owner when the ower is logged in" do
    user = create(:user)
    sign_in(:user, user)
    discussion = create(:discussion, user: user)
    get :edit, id: discussion.id
    assert_equal discussion, assigns(:discussion)
  end

  test "GET edit redirects to the discussions index if a discussion is not assigned" do
    get :edit, id: 1000
    assert_redirected_to discussions_path
  end

  test "GET edit redirects to the discussions index if the discussion guid doesn't match the guest cookie" do
    discussion = create(:discussion, user: @guest)
    @request.cookies['mybema_guest_id'] = 'different to discussion value'
    get :edit, id: discussion.id
    assert_redirected_to discussions_path
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
    post :create, discussion: { body: 'The body', title: 'The title', user_id: 5, discussion_category_id: 1 }
    assert_redirected_to discussion_path(assigns(:discussion))
  end

  test "PUT update will update a guest discussion if the guid matches the guest cookie" do
    discussion = create(:discussion, id: 5, user: @guest, body: 'changeable', guest_id: 'guest')
    @request.cookies['mybema_guest_id'] = 'guest'
    put :update, id: 5, discussion: { body: 'An updated body' }
    assert_equal discussion.reload.body, 'An updated body'
  end

  test "PUT update will not update a guest discussion if the guid differs from the guest cookie" do
    discussion = create(:discussion, id: 5, user: @guest, body: 'unchangeable')
    put :update, id: 5, discussion: { body: 'An updated body' }
    assert_equal discussion.reload.body, 'unchangeable'
  end

  test "PUT update redirects to the discussions index if a discussion is not assigned" do
    put :update, id: 0
    assert_redirected_to discussions_path
  end

  test "PUT update will redirect to discussion after updating successfully" do
    discussion = create(:discussion, id: 90, user: @guest, guest_id: 'guest')
    @request.cookies['mybema_guest_id'] = 'guest'
    put :update, id: 90, discussion: { body: 'An updated body' }
    assert_redirected_to discussion_path(discussion)
  end

  test "PUT update will render the edit page if not updated successfully" do
    discussion = create(:discussion, id: 91, user: @guest, guest_id: 'guest')
    @request.cookies['mybema_guest_id'] = 'guest'
    put :update, id: 91, discussion: { body: '' }
    assert_template 'edit'
  end
end