require 'test_helper'

class DiscussionCommenting < Capybara::Rails::TestCase
  test 'user can view and add comments to a discussion' do
    guest      = create(:user, username: 'Guest')
    category   = create(:discussion_category, name: 'Cool category')
    discussion = create(:discussion, discussion_category: category,
                                     user: guest, title: 'Good chat', body: 'This is very informative')
    create(:discussion_comment, body: 'In before 2 cents', discussion: discussion)
    visit root_path
    click_link 'Good chat'
    assert_content page, 'In before 2 cents'
    fill_in 'Have something to add?', with: 'My very valuable 2 cents'
    click_button 'Respond'
    assert_content page, 'My very valuable 2 cents'
  end
end