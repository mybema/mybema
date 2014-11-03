require 'test_helper'

class AdminDiscussionCommentsTest < Capybara::Rails::TestCase
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

  test "admin can click through to a comment's discussion page from the admin list of comments" do
    discussion = create(:discussion, title: 'A random discussion')
    create(:discussion_comment, discussion: discussion, body: 'Very insightful')
    visit admin_comments_path
    click_link 'Very insightful'
    assert_content page, 'A random discussion'
  end

  test 'admin can update an existing comment' do
    create(:discussion_comment, body: 'Some weird comment')
    visit admin_comments_path
    click_link 'manage'
    fill_in 'discussion_comment_body', with: 'No longer weird'
    click_button 'update comment'
    assert_content page, 'No longer weird'
    assert_content page, 'manage'
  end

  test 'admin can hide a comment' do
    create(:discussion_comment)
    visit admin_comments_path
    click_link 'manage'
    click_link 'hide comment'
    assert_content page, 'This comment is hidden'
  end

  test 'admin can unhide a comment' do
    create(:discussion_comment, hidden: true)
    visit admin_comments_path
    click_link 'manage'
    click_link 'show comment'
    refute_content page, 'This comment is hidden'
  end

  test 'admin sees the comment visibility in the index listing' do
    create(:discussion_comment, hidden: true)
    create(:discussion_comment)
    visit admin_comments_path
    assert_content page, 'Hidden'
    assert_content page, 'Visible'
  end

    test 'admin can delete an existing comment' do
    create(:discussion_comment, body: 'Will be removed')
    visit admin_comments_path
    click_link 'manage'
    click_link 'delete comment'
    assert_equal DiscussionComment.count, 0
  end
end