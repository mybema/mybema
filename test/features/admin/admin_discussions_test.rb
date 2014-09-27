require 'test_helper'

class AdminDiscussionsTest < Capybara::Rails::TestCase
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

  test 'admin sees the list of discussions and the list of comment responses' do
    discussion = create(:discussion, title: 'Visible in admin section')
    5.times { create(:discussion_comment, discussion: discussion) }
    visit admin_discussions_path
    assert_content page, 'Visible in admin section'
    assert_content page, '5'
  end

  test 'admin sees the category names for the discussions in the index listing' do
    category = create(:discussion_category, name: 'faint and gray')
    create(:discussion, title: 'Visible in admin section', discussion_category: category)
    visit admin_discussions_path
    assert_content page, 'faint and gray'
  end

  test 'admin can click through to a discussion page from the admin discussion list' do
    discussion = create(:discussion, title: 'Visible in admin section', body: 'Too sexy for my shirt')
    visit admin_discussions_path
    click_link 'Visible in admin section'
    assert_content page, 'Too sexy for my shirt'
  end

  test 'admin can update an existing discussion' do
    create(:discussion, title: 'Title that will change', body: 'Content that will change')
    create(:discussion_category, name: 'A different category')
    visit admin_discussions_path
    click_link 'manage'
    fill_in 'discussion_title', with: 'This is the new title'
    fill_in 'discussion_body', with: 'This is the new content'
    select 'A different category', from: 'Change category'
    click_button 'update discussion'
    assert_equal Discussion.last.title, 'This is the new title'
    assert_equal Discussion.last.body, 'This is the new content'
    assert_equal Discussion.last.discussion_category.name, 'A different category'
  end

  test 'admin can delete an existing discussion' do
    create(:discussion, title: 'Will be removed')
    visit admin_discussions_path
    click_link 'manage'
    click_link 'delete discussion'
    assert_equal Discussion.count, 0
  end

  test 'admin can create a new discussion' do
    create(:discussion_category, name: 'First')
    visit admin_discussions_path
    click_link 'New discussion'
    fill_in 'Add a title', with: 'Admin made'
    select 'First', from: 'Choose category'
    fill_in 'Add your content', with: 'Some cool content'
    click_button 'add discussion'
    assert_content page, 'Some cool content'
    assert_content page, 'Your discussion has been added'
    assert_equal Discussion.last.user_id, nil
  end

  test 'admin can hide a discussion' do
    create(:discussion, title: 'Will be removed')
    visit admin_discussions_path
    click_link 'manage'
    click_link 'hide discussion'
    assert_content page, 'This discussion is hidden'
  end

  test 'admin can unhide a discussion' do
    create(:discussion, title: 'Will be removed', hidden: true)
    visit admin_discussions_path
    click_link 'manage'
    click_link 'show discussion'
    refute_content page, 'This discussion is hidden'
  end

  test 'regular user cannot edit a discussion' do
    click_link 'Admin'
    click_link 'Sign out'
    discussion = create(:discussion, title: 'Visible in admin section', body: 'Too sexy for my shirt')
    visit edit_admin_discussion_path(discussion)
    assert_content page, 'You need to sign in or sign up before continuing.'
  end
end