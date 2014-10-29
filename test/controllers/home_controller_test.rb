require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  def setup
    create(:user, username: 'Guest')
    @hero_message = create(:hero_message)
  end

  test "GET index responds successfully" do
    get :index
    assert_response :success, @response.body
  end

  test "GET index assigns the hero message" do
    get :index
    assert_equal @hero_message, assigns(:hero_message)
  end

  test "GET index assigns the visible discussions" do
    discussion_one = create(:discussion)
    discussion_two = create(:discussion)
    discussion_three = create(:discussion, hidden: true)
    get :index
    assert_equal [discussion_two, discussion_one], assigns(:discussions)
  end
end