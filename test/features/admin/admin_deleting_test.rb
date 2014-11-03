require 'test_helper'

class AdminDeletingTest < Capybara::Rails::TestCase
  def setup
    create(:app_settings)
    create(:user, username: 'Guest')
    create(:admin, name: 'Other Admin', id: 666)
    create(:admin, name: 'Super Admin', id: 665, email: 'admin@test.com', password: 'password')
    visit root_path
    click_link 'Log in'
    click_link 'Admin sign in'
    fill_in 'Email', with: 'admin@test.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
  end

  test "admin cannot delete self" do
    visit administrators_path
    click_link 'admin_665'
    assert_content page, 'You cannot delete yourself'
  end

  test "admin can delete another admin" do
    visit administrators_path
    assert_content page, 'Other Admin'
    click_link 'admin_666'
    refute_content page, 'Other Admin'
  end
end