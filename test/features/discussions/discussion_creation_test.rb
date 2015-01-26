require 'test_helper'

class DiscussionCreation < Capybara::Rails::TestCase
  def setup
    create(:app_settings)
    create(:user, username: 'Guest')
    create(:discussion_category, name: 'Cool category')
    create(:admin)
  end

  test 'user can create a discussion' do
    visit root_path
    click_link 'Start a discussion'
    fill_in 'Add a title', with: 'A title'
    select 'Cool category', from: 'Choose category'
    fill_in 'Add your content', with: 'Some cool content'
    click_button 'add discussion'
    assert_content page, 'Some cool content'
    assert_content page, 'Your discussion has been added'
  end

  test 'user sees validation errors when unsuccessfully creating a new discussion' do
    visit root_path
    click_link 'Start a discussion'
    click_button 'add discussion'
    assert_content page, 'Your discussion could not be created'
    assert_content page, 'A category needs to be added'
    assert_content page, 'Some content needs to be added'
    assert_content page, 'Your title needs to be added'
  end
end