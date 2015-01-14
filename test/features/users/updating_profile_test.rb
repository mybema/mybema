require 'test_helper'

class UpdatingProfile < Capybara::Rails::TestCase
  def setup
    create(:app_settings)
    create(:user, username: 'Guest')
  end

  test 'guest user cannot view their profile page' do
    visit profile_path
    assert_content page, 'You have to be signed in to do that'
    refute_content page, 'Profile'
  end

  test 'signed in users can update their profiles' do
    create(:user, email: 'bob@gmail.com', password: 'password')
    visit root_path
    click_link 'Log in'
    fill_in 'Email', with: 'bob@gmail.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
    visit profile_path
    fill_in 'Name', with: 'New bobby'
    fill_in 'Email address', with: 'newbobby@gmail.com'
    fill_in 'Bio', with: 'something interesting'
    click_button 'update profile'
    assert_content page, 'Your profile was updated'
    assert_equal User.last.name, 'New bobby'
    assert_equal User.last.email, 'newbobby@gmail.com'
    assert_equal User.last.bio, 'something interesting'
  end
end