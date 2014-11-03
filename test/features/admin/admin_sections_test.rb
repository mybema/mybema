require 'test_helper'

class AdminSectionsTest < Capybara::Rails::TestCase
  def setup
    create(:app_settings)
    create(:user, username: 'Guest')
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
    visit admin_sections_path
    assert_content page, 'Only section'
  end

  test 'admin can click through to a section page that lists its articles' do
    section = create(:section, title: 'Only section')
    article = create(:article, title: 'A short article', section: section)
    visit admin_sections_path
    click_link 'Only section'
    assert_content page, 'A short article'
  end

  test 'admin can update an existing section' do
    section = create(:section, title: 'Old title')
    visit admin_sections_path
    click_link 'manage'
    fill_in 'section_title', with: 'New title'
    click_button 'update section'
    assert_content page, 'New title'
  end

  test 'admin can delete an existing section' do
    create(:section, title: 'Will be removed')
    visit admin_sections_path
    click_link 'manage'
    click_link 'delete section'
    assert_equal Section.count, 0
  end

  test 'admin can create a new section' do
    visit admin_sections_path
    click_link 'New section'
    fill_in 'section_title', with: 'Brand new'
    click_button 'add section'
    assert_equal Section.last.title, 'Brand new'
  end

  test 'admin is redirected to the new section article listing after creating it' do
    visit admin_sections_path
    click_link 'New section'
    fill_in 'section_title', with: 'Learn you a thing'
    click_button 'add section'
    assert_content page, 'The Learn you a thing section has 0 articles'
  end
end