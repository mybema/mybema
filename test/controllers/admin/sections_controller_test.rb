require 'test_helper'

class Admin::SectionsControllerTest < ActionController::TestCase
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

  test "GET index assigns the sections by most recently updated" do
    section_one = create(:section)
    section_two = create(:section)
    get :index
    assert_equal [section_two, section_one], assigns(:sections)
  end

  test "GET new responds successfully" do
    get :new
    assert_response :success, @response.body
  end

   test "GET new renders the correct template" do
    get :new
    assert_template 'new'
  end

  test "GET new assigns a new section" do
    get :new
    assigns(:section).must_be_kind_of Section
  end

  test "GET edit responds successfully" do
    create(:section, id: 42)
    get :edit, id: 42
    assert_response :success, @response.body
  end

  test "GET edit assigns the section" do
    section = create(:section, id: 43)
    get :edit, id: 43
    assert_equal section, assigns(:section)
  end

  test "PUT update assigns the section" do
    section = create(:section, id: 5)
    put :update, id: 5, section: { title: 'An updated title' }
    assert_equal section, assigns(:section)
  end

  test "PUT update will update the section" do
    section = create(:section, id: 55)
    put :update, id: 55, section: { title: 'An updated title' }
    assert_equal section.reload.title, 'An updated title'
  end

  test "PUT update will redirect to the admin sections index updating successfully" do
    section = create(:section, id: 56)
    put :update, id: 56, section: { title: 'An updated title' }
    assert_redirected_to admin_sections_path
  end

  test "PUT update will render the edit page if not updated successfully" do
    section = create(:section, id: 57)
    put :update, id: 57, section: { title: '' }
    assert_template 'edit'
  end

  test "GET show responds successfully" do
    create(:section, id: 62)
    get :show, id: 62
    assert_response :success, @response.body
  end

  test "GET show assigns the section" do
    section = create(:section, id: 63)
    get :show, id: 63
    assert_equal section, assigns(:section)
  end

  test "GET show assigns the section's articles" do
    section = create(:section, id: 63)
    article = create(:article, section: section)
    get :show, id: 63
    assert_equal [article], assigns(:articles)
  end

  test "DELETE destroy assigns the section" do
    section = create(:section, id: 301)
    delete :destroy, id: 301
    assert_equal section, assigns(:section)
  end

  test "DELETE destroy will destroy a section" do
    create(:section, id: 302)
    assert_difference 'Section.count', -1 do
      delete :destroy, id: 302
    end
  end

  test "DELETE destroy redirects to the section index" do
    create(:section, id: 303)
    delete :destroy, id: 303
    assert_redirected_to admin_sections_path
  end
end