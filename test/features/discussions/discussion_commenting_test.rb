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

  test 'admin can respond to discussion comment on actual discussion page' do
    guest      = create(:user, username: 'Guest')
    admin      = create(:admin, name: 'Super Admin', email: 'admin@test.com', password: 'password')
    category   = create(:discussion_category, name: 'Cool category')
    discussion = create(:discussion, discussion_category: category,
                                     user: guest, title: 'Good chat', body: 'This is very informative')
    visit root_path
    click_link 'Log in'
    click_link 'Admin sign in'
    fill_in 'Email', with: 'admin@test.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
    visit discussion_path(discussion)
    fill_in 'Have something to add?', with: 'I am the almighty admin'
    click_button 'Respond'
    assert_content page, 'I am the almighty admin'
    assert_content page, 'Super Admin posted'
  end
end