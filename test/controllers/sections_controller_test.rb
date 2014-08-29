require 'test_helper'

class SectionsControllerTest < ActionController::TestCase
  def setup
    create(:user, username: 'Guest')
  end

  test "GET index responds successfully" do
    get :index
    assert_response :success, @response.body
  end

  test "GET index assigns sections scoped to those with articles" do
    section1 = create(:section)
    section2 = create(:section)
    section3 = create(:section)
    create(:article, section: section1)
    create(:article, section: section2)
    get :index
    assert_equal [section1, section2], assigns(:sections)
  end
end