require 'test_helper'

class LoggingInAndOutTest < Capybara::Rails::TestCase
  test 'user can log in' do
    create(:user, username: 'Guest')
    create(:user, email: 'bob@gmail.com', password: 'password')
    visit root_path
    click_link 'Log in'
    fill_in 'Email', with: 'bob@gmail.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
    assert_content page, 'Signed in successfully'
    assert_content page, 'Log out'
    refute_content page, 'Log in'
  end

  test 'user can sign in and out again' do
    create(:user, username: 'Guest')
    create(:user, email: 'bob@gmail.com', password: 'password')
    visit root_path
    click_link 'Log in'
    fill_in 'Email', with: 'bob@gmail.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
    assert_content page, 'Signed in successfully'
    click_link 'Log out'
    assert_content page, 'Signed out successfully'
    assert_content page, 'Log in'
    refute_content page, 'Log out'
  end
end