require 'test_helper'

class DiscussionFiltering < Capybara::Rails::TestCase
  test 'user can find and view existing discussion from the homepage' do
    guest = create(:user, username: 'Guest')
    category = create(:discussion_category, name: 'Cool category')
    discussion = create(:discussion, discussion_category: category, user: guest)
    visit root_path
    click_link discussion.title
    assert_content page, discussion.body
  end

  test 'user can find and view existing discussion from the community page' do
    guest = create(:user, username: 'Guest')
    category = create(:discussion_category, name: 'Cool category')
    discussion = create(:discussion, discussion_category: category, user: guest)
    visit root_path
    click_link 'Community'
    click_link discussion.title
    assert_content page, discussion.body
  end
end