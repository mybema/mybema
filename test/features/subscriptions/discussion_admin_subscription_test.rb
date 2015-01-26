require 'test_helper'
require 'sidekiq/testing'

Sidekiq::Testing.inline!

class DiscussionAdminSubscriptionTest < Capybara::Rails::TestCase
  def setup
    create(:app_settings)
    @guest = create(:user, username: 'Guest')
  end

  def sign_in_as_admin
    create(:admin, name: 'Super Admin', email: 'admin@test.com', password: 'password')
    visit root_path
    click_link 'Log in'
    click_link 'Admin sign in'
    fill_in 'Email', with: 'admin@test.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
  end

  test 'responding as admin will not create a subscription' do
    discussion = create(:discussion, user: @guest)
    sign_in_as_admin
    visit discussion_path(discussion.slug)
    fill_in 'Have something to add?', with: 'Responding as admin will not create a sub'
    click_button 'Respond'
    assert_equal 0, Subscription.count
  end

  test 'admins cannot see the subscribe or unsubscribe links' do
    discussion = create(:discussion, user: @guest)
    sign_in_as_admin
    visit discussion_path(discussion.slug)
    refute page.has_link? 'subscribe'
    refute page.has_link? 'unsubscribe'
  end

  test 'admin creating a new discussion will not create a subscription' do
    create(:discussion_category, name: 'Cool category')
    discussion = create(:discussion, user: @guest)
    sign_in_as_admin
    visit new_discussion_path
    fill_in 'Add a title', with: 'A title'
    select 'Cool category', from: 'Choose category'
    fill_in 'Add your content', with: 'Some cool content'
    click_button 'add discussion'
    assert_equal Subscription.count, 0
  end
end