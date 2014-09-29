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

  test 'user can see link to register on sign in page' do
    create(:user, username: 'Guest')
    visit root_path
    click_link 'Log in'
    click_link 'Not part of the community yet? Sign up.'
    assert_content page, 'Already a member? Sign in.'
  end

  test 'admin cannot see link to register on sign in page' do
    create(:user, username: 'Guest')
    visit root_path
    click_link 'Log in'
    click_link 'Admin sign in'
    refute_content page, 'Not part of the community yet? Sign up.'
  end

  test 'admin can sign in' do
    create(:user, username: 'Guest')
    create(:admin, name: 'Super Admin', email: 'admin@test.com', password: 'password')
    visit root_path
    click_link 'Log in'
    click_link 'Admin sign in'
    fill_in 'Email', with: 'admin@test.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
    assert_link 'Admin'
  end

  test 'admin can sign out' do
    create(:user, username: 'Guest')
    create(:admin, name: 'Super Admin', email: 'admin@test.com', password: 'password')
    visit root_path
    click_link 'Log in'
    click_link 'Admin sign in'
    fill_in 'Email', with: 'admin@test.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
    click_link 'Sign out'
    assert_content page, 'Signed out successfully.'
  end

  test 'admin is redirected to dashboard after signing in' do
    create(:user, username: 'Guest')
    create(:admin, name: 'Super Admin', email: 'admin@test.com', password: 'password')
    visit root_path
    click_link 'Log in'
    click_link 'Admin sign in'
    fill_in 'Email', with: 'admin@test.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
    assert_content page, 'Welcome to your dashboard'
  end
end