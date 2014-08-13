require 'test_helper'

class RegisteringTest < Capybara::Rails::TestCase
  test 'user can sign up' do
    create(:user, username: 'Guest')
    visit root_path
    click_link 'join community'
    fill_in 'Email', with: 'bob@gmail.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    assert_content page, 'Welcome! You have signed up successfully'
    refute_content page, 'join community'
    assert_content page, 'Log out'
    refute_content page, 'Log in'
  end
end