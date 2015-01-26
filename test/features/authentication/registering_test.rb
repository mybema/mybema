require 'test_helper'
require 'sidekiq/testing'

Sidekiq::Testing.inline!

class RegisteringTest < Capybara::Rails::TestCase
  def setup
    create(:app_settings)
    create(:admin)
    @guest = create(:user, username: 'Guest')
  end

  test 'user can sign up' do
    visit root_path
    click_link 'Join the community'
    fill_in 'Email', with: 'bob@gmail.com'
    fill_in 'Username', with: 'bobby_G'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    assert_content page, 'Welcome! You have signed up successfully'
    refute_content page, 'Join the community'
    assert_content page, 'Log out'
    refute_content page, 'Log in'
  end

  test 'user cannot sign up with parameterized version of an existing username' do
    create(:user, username: 'John Doe')
    visit root_path
    click_link 'Join the community'
    fill_in 'Email', with: 'bob@gmail.com'
    fill_in 'Username', with: 'john-doe'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    refute_content page, 'Welcome! You have signed up successfully'
  end

  test 'user cannot sign up with humanized version of an existing parameterized username' do
    create(:user, username: 'john-doe')
    visit root_path
    click_link 'Join the community'
    fill_in 'Email', with: 'bob@gmail.com'
    fill_in 'Username', with: 'John Doe'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    refute_content page, 'Welcome! You have signed up successfully'
  end

  test 'discussion created when guest is transfered to new account' do
    create(:discussion_category, name: 'Cool category')
    visit root_path
    click_link 'Start a discussion'
    fill_in 'Add a title', with: 'A title'
    select 'Cool category', from: 'Choose category'
    fill_in 'Add your content', with: 'Some cool content'
    click_button 'add discussion'
    assert_equal @guest.discussions.count, 1
    visit root_path
    click_link 'Join the community'
    fill_in 'Username', with: 'bob'
    fill_in 'Email', with: 'bob@gmail.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    assert_equal @guest.discussions.count, 0
    assert_nil Discussion.last.guest_id
    assert_equal Discussion.last.user_id, User.last.id
  end

  test 'comment created when guest is transfered to new account' do
    discussion = create(:discussion, user: @guest)
    visit discussion_path(discussion.slug)
    fill_in 'Have something to add?', with: 'My very valuable 2 cents'
    click_button 'Respond'
    assert_equal @guest.discussion_comments.count, 1
    visit root_path
    click_link 'Join the community'
    fill_in 'Username', with: 'bob'
    fill_in 'Email', with: 'bob@gmail.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    assert_equal @guest.discussion_comments.count, 0
    assert_nil DiscussionComment.last.guest_id
    assert_equal DiscussionComment.last.user_id, User.last.id
  end
end