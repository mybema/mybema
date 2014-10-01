require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  def setup
    create(:user, username: 'Guest')
  end

  test "GET show assigns the article" do
    article = create(:article, id: 81)
    get :show, id: 81
    assert_equal article, assigns(:article)
  end
end