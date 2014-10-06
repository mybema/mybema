require 'test_helper'

class DashboardTest < Capybara::Rails::TestCase
  def setup
    create(:user, username: 'Guest')
  end

  test "visitors cannot access sidekiq dashboard" do
    visit 'admin/sidekiq'
    assert_content page, 'You need to sign in or sign up before continuing'
  end

  test "admins can access sidekiq dashboard" do
    create(:admin, name: 'Super Admin', email: 'admin@test.com', password: 'password')
    visit root_path
    click_link 'Log in'
    click_link 'Admin sign in'
    fill_in 'Email', with: 'admin@test.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
    visit 'admin/sidekiq'
    assert_content page, 'Sidekiq'
    refute_content page, 'You need to sign in or sign up before continuing'
  end
end