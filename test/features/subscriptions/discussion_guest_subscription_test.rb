require 'test_helper'
require 'sidekiq/testing'

Sidekiq::Testing.inline!

class DiscussionSubscriptionTest < Capybara::Rails::TestCase
  def setup
    create(:app_settings)
    create(:admin)
    @guest = create(:user, username: 'Guest')
  end

  test 'simply responding as a guest will not create a subscription' do
    discussion = create(:discussion, user: @guest)
    visit discussion_path(discussion.slug)
    fill_in 'Have something to add?', with: 'This will not create a sub'
    click_button 'Respond'
    assert_equal 0, Subscription.count
  end

  test 'responding as a guest and supplying an email address will create a subscription' do
    discussion = create(:discussion, user: @guest)
    visit discussion_path(discussion.slug)
    fill_in 'Have something to add?', with: 'This will not create another sub'
    fill_in 'guest_email', with: 'guest@gmail.com'
    click_button 'Respond'
    assert_equal Subscription.count, 1
  end

  test 'guest users cannot see the subscribe or unsubscribe links' do
    discussion = create(:discussion, user: @guest)
    visit discussion_path(discussion.slug)
    refute page.has_link? 'subscribe'
    refute page.has_link? 'unsubscribe'
  end

  test 'guest creating a new discussion will create a subscription if an email address is provided' do
    create(:discussion_category, name: 'Cool category')
    visit new_discussion_path
    fill_in 'Add a title', with: 'A title'
    select 'Cool category', from: 'Choose category'
    fill_in 'Add your content', with: 'Some cool content'
    fill_in 'guest_email', with: 'guest@gmail.com'
    click_button 'add discussion'
    assert_equal Subscription.count, 1
  end

  test 'guest creating a new discussion will not create a subscription if an email address is omitted' do
    create(:discussion_category, name: 'Cool category')
    visit new_discussion_path
    fill_in 'Add a title', with: 'A title'
    select 'Cool category', from: 'Choose category'
    fill_in 'Add your content', with: 'Some cool content'
    click_button 'add discussion'
    assert_equal Subscription.count, 0
  end
end