require 'test_helper'

class DiscussionFiltering < Capybara::Rails::TestCase
  def setup
    create(:app_settings)
    guest = create(:user, username: 'Guest')
    category = create(:discussion_category, name: 'Cool category')
    @discussion = create(:discussion, discussion_category: category, user: guest)
  end

  test 'user can find and view existing discussion from the homepage' do
    visit root_path
    within('.single-community-item--lens') do
      click_link @discussion.title
    end
    assert_content page, @discussion.body
  end

  test 'user can find and view existing discussion from the community page' do
    visit root_path
    click_link 'Discussions'
    within('.single-community-item--lens') do
      click_link @discussion.title
    end
    assert_content page, @discussion.body
  end
end