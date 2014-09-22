require 'test_helper'

class ManagingGuidelinesTest < Capybara::Rails::TestCase
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

  test "admin can view the list of guidelines in the dashboard" do
    create(:guideline, name: 'A simple guideline')
    visit guidelines_path
    assert_content page, 'A simple guideline'
  end

  test "admin can add a new guideline" do
    visit guidelines_path
    click_link 'add guideline'
    fill_in 'guideline_name', with: 'Another simple guideline'
    click_button 'add guideline'
    assert_content page, 'Another simple guideline'
    assert_content page, 'add guideline'
  end

  test "admin can remove a guideline" do
    create(:guideline, name: 'A simple guideline')
    visit guidelines_path
    click_link 'delete'
    refute_content page, 'A simple guideline'
  end
end