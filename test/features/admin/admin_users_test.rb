require 'test_helper'

class AdminUsersTest < Capybara::Rails::TestCase
  def setup
    create(:user, username: 'Guest')
    create(:admin, name: 'Super Admin', email: 'admin@test.com', password: 'password')
    visit root_path
    click_link 'Log in'
    click_link 'Admin sign in'
    fill_in 'Email', with: 'admin@test.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
  end

  test "admin see a list of all users" do
    user = create(:user, name: 'Natalia Turcotte')
    discussion = create(:discussion, user: user)
    create(:discussion_comment, discussion: discussion, user: user)
    visit admin_users_path
    assert_content page, 'Guest'
    assert_content page, 'Natalia Turcotte'
  end
end