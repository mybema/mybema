require 'test_helper'
require 'sidekiq/testing'

Sidekiq::Testing.inline!

class DiscussionSubscriptionTest < Capybara::Rails::TestCase
  def setup
    create(:app_settings)
    create(:admin)
    @guest = create(:user, username: 'Guest')
    @discussion = create(:discussion, user: @guest)
  end

  def sign_user_in
    @user = create(:user, email: 'bob@gmail.com', password: 'password')
    visit root_path
    click_link 'Log in'
    fill_in 'Email', with: 'bob@gmail.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
  end

  test 'user creating a new discussion will create a subscription' do
    create(:discussion_category, name: 'Cool category')
    sign_user_in
    visit new_discussion_path
    fill_in 'Add a title', with: 'A title'
    select 'Cool category', from: 'Choose category'
    fill_in 'Add your content', with: 'Some cool content'
    click_button 'add discussion'
    assert_equal Subscription.count, 1
  end

  test 'user can subscribe to a discussion by clicking on the subscribe link' do
    sign_user_in
    visit discussion_path(@discussion.slug)
    click_link 'subscribe'
    assert_content page, 'You have been subscribed to this discussion'
    assert page.has_link? 'unsubscribe'
    assert_equal Subscription.last.user_id, @user.id
    assert_equal Subscription.last.discussion_id, @discussion.id
    assert_equal Subscription.last.subscribed, true
  end

  test 'user can unsubscribe from discussion by clicking on the unsubscribe link' do
    sign_user_in
    @discussion.subscriptions.create(user: @user)
    visit discussion_path(@discussion.slug)
    click_link 'unsubscribe'
    assert_content page, 'You have been unsubscribed from this discussion'
    assert_equal Subscription.last.subscribed, false
    assert page.has_link? 'subscribe'
  end

  test 'user can subscribe to a discussion by responding to it' do
    sign_user_in
    visit discussion_path(@discussion.slug)
    fill_in 'Have something to add?', with: 'I want to subscribe to this'
    click_button 'Respond'
    assert page.has_link? 'unsubscribe'
    assert_equal Subscription.last.user_id, @user.id
    assert_equal Subscription.last.discussion_id, @discussion.id
    assert_equal Subscription.last.subscribed, true
  end

  test 'user will not subscribe to a discussion by responding to it if s(he) has previously unsubscribed' do
    sign_user_in
    @discussion.subscriptions.create(user: @user, subscribed: false)
    visit discussion_path(@discussion.slug)
    assert page.has_link? 'subscribe'
    fill_in 'Have something to add?', with: 'This will not resubscribe me'
    click_button 'Respond'
    assert page.has_link? 'subscribe'
  end

  test 'responding twice will not create an additional subscription' do
    sign_user_in
    @discussion.subscriptions.create(user: @user)
    visit discussion_path(@discussion.slug)
    assert_equal Subscription.count, 1
    fill_in 'Have something to add?', with: 'This will not create another sub'
    click_button 'Respond'
    assert_equal Subscription.count, 1
  end
end