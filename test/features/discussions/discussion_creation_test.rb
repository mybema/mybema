require 'test_helper'

class DiscussionCreation < Capybara::Rails::TestCase
  test 'user can create a discussion' do
    create(:user, username: 'Guest')
    create(:discussion_category, name: 'Cool category')
    visit root_path
    click_link 'add discussion'
    fill_in 'Add a title', with: 'A title'
    select 'Cool category', from: 'Choose category'
    fill_in 'Add your content', with: 'Some cool content'
    click_button 'add discussion'
    assert_content page, 'Some cool content'
  end
end