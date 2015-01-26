require 'test_helper'

class DiscussionEditing < Capybara::Rails::TestCase
  def setup
    create(:app_settings)
    create(:admin)
    @guest = create(:user, username: 'Guest')
  end

  test 'guest can edit a guest discussion if the discussion guid matches their cookie guid' do
    create(:discussion_category, name: 'Cool category')
    visit root_path
    click_link 'Start a discussion'
    fill_in 'Add a title', with: 'A title'
    select 'Cool category', from: 'Choose category'
    fill_in 'Add your content', with: 'Some cool content'
    click_button 'add discussion'
    click_link 'Edit this post'
    fill_in 'Title', with: 'A different title'
    fill_in 'Content', with: 'Some lame content'
    click_button 'update discussion'
    assert_content page, 'Some lame content'
    assert_content page, 'Your discussion has been updated'
  end

  test 'guest cannot edit a guest discussion if the discussion guid differs from their cookie guid' do
    discussion = create(:discussion, title: 'Not my discussion')
    visit discussion_path(discussion.slug)
    refute_content page, 'Edit this post'
    visit edit_discussion_path(discussion.slug)
    assert_content page, "You don't have permission to do that"
  end

  test 'signed in user can edit their own discussion' do
    user = create(:user, email: 'bob@gmail.com', password: 'password')
    discussion = create(:discussion, user: user, title: "Bob's discussion")
    visit root_path
    click_link 'Log in'
    fill_in 'Email', with: 'bob@gmail.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
    visit discussion_path(discussion.slug)
    click_link 'Edit this post'
    fill_in 'Title', with: 'Still belong to Bob'
    click_button 'update discussion'
    assert_content page, 'Still belong to Bob'
    assert_content page, 'Your discussion has been updated'
  end

  test "signed in user cannot edit another user's discussion" do
    user = create(:user, email: 'bob@gmail.com', password: 'password')
    discussion = create(:discussion, user: @guest, title: "Guest's discussion")
    visit root_path
    click_link 'Log in'
    fill_in 'Email', with: 'bob@gmail.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
    visit discussion_path(discussion.slug)
    refute_content page, 'Edit this post'
    visit edit_discussion_path(discussion.slug)
    assert_content page, "You don't have permission to do that"
  end
end