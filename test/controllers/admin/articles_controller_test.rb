require 'test_helper'

class Admin::ArticlesControllerTest < ActionController::TestCase
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

  test "GET index assigns the articles by recency" do
    article_one = create(:article)
    article_two = create(:article)
    get :index
    assert_equal [article_two, article_one], assigns(:articles)
  end

  test "GET new responds successfully" do
    create(:section, id: 3)
    get :new, admin_section_id: 3
    assert_response :success, @response.body
  end

   test "GET new renders the correct template" do
    create(:section, id: 4)
    get :new, admin_section_id: 4
    assert_template 'new'
  end

  test "GET new assigns a new article" do
    create(:section, id: 5)
    get :new, admin_section_id: 5
    assigns(:article).must_be_kind_of Article
  end

  test "GET new assigns the article's section" do
    section = create(:section, id: 69)
    get :new, admin_section_id: 69
    assert_equal section, assigns(:section)
  end

  test "POST create will create an article" do
    section = create(:section, id: 10)
    assert_difference 'Article.count', 1 do
      post :create, admin_section_id: 10, article: { title: 'title', body: 'body', section_id: 10 }
    end
  end

  test "POST create redirects to the admin section path if successfully created" do
    section = create(:section, id: 11)
    post :create, admin_section_id: 11, article: { title: 'title', body: 'body', section_id: 11 }
    assert_redirected_to admin_section_path(section)
  end

  test "POST create will not create an article if it is invalid" do
    create(:section, id: 12)
    assert_difference 'Article.count', 0 do
      post :create, admin_section_id: 12, article: { title: '', body: '', section_id: 12 }
    end
  end

  test "POST create will render the new template if create is not successful" do
    create(:section, id: 13)
    post :create, admin_section_id: 13, article: { title: '', body: '', section_id: 13 }
    assert_template 'new'
  end

  test "POST create assigns a new article" do
    create(:section, id: 14)
    post :create, admin_section_id: 14, article: { title: '', body: '', section_id: 14 }
    assigns(:article).must_be_kind_of Article
  end

  test "POST create assigns the section" do
    section = create(:section, id: 15)
    post :create, admin_section_id: 15, article: { title: '', body: '', section_id: 15 }
    assert_equal section, assigns(:section)
  end

  test "GET edit responds successfully" do
    create(:section, id: 68)
    create(:article, id: 3)
    get :edit, admin_section_id: 68, id: 3
    assert_response :success, @response.body
  end

  test "GET edit assigns the article" do
    create(:section, id: 67)
    article = create(:article, id: 4)
    get :edit, admin_section_id: 67, id: 4
    assert_equal article, assigns(:article)
  end

  test "GET edit assigns the section" do
    section = create(:section, id: 64)
    create(:article, id: 6)
    get :edit, admin_section_id: 64, id: 6
    assert_equal section, assigns(:section)
  end

  test "PUT update assigns the article" do
    create(:section, id: 61)
    article = create(:article, id: 34)
    put :update, admin_section_id: 61, id: 34, article: { title: 'new', body: 'new' }
    assert_equal article, assigns(:article)
  end

  test "PUT update assigns the section" do
    section = create(:section, id: 62)
    create(:article, id: 35)
    put :update, admin_section_id: 62, id: 35, article: { title: 'new', body: 'new' }
    assert_equal section, assigns(:section)
  end

  test "PUT update will update the article" do
    create(:section, id: 63)
    article = create(:article, id: 36)
    put :update, admin_section_id: 63, id: 36, article: { title: 'new', body: 'new' }
    assert_equal article.reload.body, 'new'
    assert_equal article.reload.title, 'new'
  end

  test "PUT update will redirect to the admin section after updating successfully" do
    section = create(:section, id: 93)
    create(:article, id: 37)
    put :update, admin_section_id: 93, id: 37, article: { title: 'new', body: 'new' }
    assert_redirected_to admin_section_path(section)
  end

  test "PUT update will render the edit page if not updated successfully" do
    create(:section, id: 92)
    create(:article, id: 39)
    put :update, admin_section_id: 92, id: 39, article: { title: '', body: '' }
    assert_template 'edit'
  end

  test "DELETE destroy assigns the article" do
    article = create(:article, id: 301)
    delete :destroy, id: 301, admin_section_id: 1
    assert_equal article, assigns(:article)
  end

  test "DELETE destroy will destroy the article" do
    create(:article, id: 302)
    assert_difference 'Article.count', -1 do
      delete :destroy, id: 302, admin_section_id: 1
    end
  end

  test "DELETE destroy redirects to the article index" do
    create(:article, id: 303)
    delete :destroy, id: 303, admin_section_id: 1
    assert_redirected_to admin_articles_path
  end
end