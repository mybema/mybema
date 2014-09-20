require 'test_helper'

class AdminDiscussionCommentsTest < Capybara::Rails::TestCase
  def setup
    create(:user, username: 'Guest')
    create(:admin, name: 'Super Admin', email: 'admin@test.com', password: 'password')
    visit root_path
    click_link 'Log in'
    click_link 'Admin sign in'
    fill_in 'Email', with: 'admin@test.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
  end

  test "admin can click through to a comment's discussion page from the admin list of comments" do
    discussion = create(:discussion, title: 'A random discussion')
    create(:discussion_comment, discussion: discussion, body: 'Very insightful')
    visit admin_comments_path
    click_link 'Very insightful'
    assert_content page, 'A random discussion'
  end
end