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
    assert_equal AppSettings.first.hero_message, 'A shorter message'
  end

  test 'admin can toggle guest posting' do
    visit app_settings_path
    click_button 'disable guest posting'
    assert_content page, 'Guest posting setting changed'
    assert_equal AppSettings.first.guest_posting, false
  end

  test 'admin can update the Google Analytics tracking code' do
    visit app_settings_path
    fill_in 'Your GA code', with: 'UA-12345678-1'
    click_button 'update tracking code'
    assert_content page, 'App settings have been updated'
    assert_equal AppSettings.first.ga_code, 'UA-12345678-1'
  end

  test 'admin can update their SMTP settings' do
    visit app_settings_path
    fill_in 'SMTP Address', with: 'stmp.example.com'
    fill_in 'SMTP Port', with: '123'
    fill_in 'SMTP Domain', with: 'example.com'
    fill_in 'SMTP Username', with: 'test username'
    fill_in 'SMTP Password', with: 'test password'
    fill_in 'From address', with: 'test1@example.com'
    fill_in 'reply-to address', with: 'test2@example.com'
    click_button 'update email settings'
    assert_content page, 'App settings have been updated'
    assert_equal AppSettings.first.smtp_address, 'stmp.example.com'
    assert_equal AppSettings.first.smtp_port, 123
    assert_equal AppSettings.first.smtp_domain, 'example.com'
    assert_equal AppSettings.first.smtp_username, 'test username'
    assert_equal AppSettings.first.smtp_password, 'test password'
    assert_equal AppSettings.first.mailer_sender, 'test1@example.com'
    assert_equal AppSettings.first.mailer_reply_to, 'test2@example.com'
  end

  test 'admin can update the Google Analytics domain address' do
    visit app_settings_path
    fill_in 'GA Domain', with: 'http://example.example.com'
    click_button 'update domain'
    assert_content page, 'App settings have been updated'
    assert_equal AppSettings.first.domain_address, 'http://example.example.com'
  end

  test 'admin can update the community title' do
    visit app_settings_path
    fill_in 'Community title', with: 'A new title'
    click_button 'update title'
    assert_content page, 'App settings have been updated'
    assert_equal AppSettings.first.community_title, 'A new title'
  end

  test 'admin can update the welcome mailer copy' do
    visit app_settings_path
    fill_in 'Welcome mailer copy', with: 'Hello new user'
    click_button 'update welcome email'
    assert_content page, 'App settings have been updated'
    assert_equal AppSettings.first.welcome_mailer_copy, 'Hello new user'
  end
end