require 'test_helper'

class AdminAppSettingsTest < Capybara::Rails::TestCase
  def setup
    create(:user, username: 'Guest')
    create(:app_settings)
    create(:admin, name: 'Super Admin', email: 'admin@test.com', password: 'password')
    visit root_path
    click_link 'Log in'
    click_link 'Admin sign in'
    fill_in 'Email', with: 'admin@test.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
  end

  test 'admin sees the list of sections' do
    create(:section, title: 'Only section')
    visit app_settings_path
    fill_in 'Hero message', with: 'A shorter message'
    click_button 'update hero message'
    assert_content page, 'App settings have been updated'
    visit root_path
    assert_content page, 'A shorter message'
  end

  test 'admin can update the Google Analytics tracking code' do
    visit app_settings_path
    fill_in 'Your GA code', with: 'UA-12345678-1'
    click_button 'update tracking code'
    assert_content page, 'App settings have been updated'
    assert_equal AppSettings.first.ga_code, 'UA-12345678-1'
  end
end