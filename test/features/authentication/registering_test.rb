require 'test_helper'
require 'sidekiq/testing'

Sidekiq::Testing.inline!

class RegisteringTest < Capybara::Rails::TestCase
  test 'user can sign up' do
    create(:user, username: 'Guest')
    visit root_path
    click_link 'join community'
    fill_in 'Email', with: 'bob@gmail.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    assert_content page, 'Welcome! You have signed up successfully'
    refute_content page, 'join community'
    assert_content page, 'Log out'
    refute_content page, 'Log in'
  end

  test 'discussion created when guest is transfered to new account' do
    guest = create(:user, id: 65, username: 'Guest')
    create(:discussion_category, name: 'Cool category')
    visit root_path
    click_link 'add discussion'
    fill_in 'Add a title', with: 'A title'
    select 'Cool category', from: 'Choose category'
    fill_in 'Add your content', with: 'Some cool content'
    click_button 'add discussion'
    assert_equal guest.discussions.count, 1
    visit root_path
    click_link 'join community'
    fill_in 'Email', with: 'bob@gmail.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    assert_equal guest.discussions.count, 0
    assert_nil Discussion.last.guest_id
    assert_equal Discussion.last.user_id, User.last.id
  end

  test 'comment created when guest is transfered to new account' do
    guest = create(:user, id: 66, username: 'Guest')
    discussion = create(:discussion, user: guest)
    visit discussion_path(discussion)
    fill_in 'Have something to add?', with: 'My very valuable 2 cents'
    click_button 'Respond'
    assert_equal guest.discussion_comments.count, 1
    visit root_path
    click_link 'join community'
    fill_in 'Email', with: 'bob@gmail.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    assert_equal guest.discussion_comments.count, 0
    assert_nil DiscussionComment.last.guest_id
    assert_equal DiscussionComment.last.user_id, User.last.id
  end
end