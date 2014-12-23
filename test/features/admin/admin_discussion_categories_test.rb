require 'test_helper'

class AdminDiscussionCategoriesTest < Capybara::Rails::TestCase
  def setup
    create(:app_settings)
    create(:user, username: 'Guest')
    create(:admin, name: 'Super Admin', email: 'admin@test.com', password: 'password')
    visit root_path
    click_link 'Log in'
    click_link 'Admin sign in'
    fill_in 'Email', with: 'admin@test.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
  end

  test 'admin can create a category' do
    visit admin_path
    click_link 'Categories'
    click_link 'new category'
    fill_in 'discussion_category_name', with: 'Series'
    click_button 'add category'
    assert_content page, 'Series'
    assert_content page, 'Your category has been added'
  end

  test 'admin can update a category' do
    create(:discussion_category, name: 'old name')
    visit admin_path
    click_link 'Categories'
    click_link 'manage'
    fill_in 'discussion_category_name', with: 'new name'
    click_button 'update category'
    assert_content page, 'new name'
    assert_content page, 'Your category has been updated'
  end

  test 'admin can delete a category' do
    create(:discussion_category, name: 'removable category')
    visit admin_path
    click_link 'Categories'
    click_link 'manage'
    click_link 'delete category'
    refute_content page, 'removable category'
  end
end