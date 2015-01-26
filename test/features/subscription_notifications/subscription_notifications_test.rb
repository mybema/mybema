require 'test_helper'
require 'sidekiq/testing'

Sidekiq::Testing.inline!

class SubscriptionNotificationsTest < Capybara::Rails::TestCase
  def setup
    create(:app_settings)
    create(:admin, email: 'admin-address@example.com')
    @guest = create(:user, username: 'Guest')
    ActionMailer::Base.deliveries.clear
  end

  def respond_as_guest_to(discussion)
    visit discussion_path(discussion.slug)
    fill_in 'Have something to add?', with: 'This will not create another sub'
    fill_in 'guest_email', with: 'guest@gmail.com'
    click_button 'Respond'
  end

  def sign_user_in
    @user = create(:user, email: 'bob@gmail.com', password: 'password')
    visit root_path
    click_link 'Log in'
    fill_in 'Email', with: 'bob@gmail.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
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

  test 'responding as a guest will notify the admins' do
    discussion = create(:discussion, user: @guest, title: 'A discussion')
    respond_as_guest_to(discussion)

    mail = ActionMailer::Base.deliveries.last
    assert_equal 'admin-address@example.com', mail['to'].to_s
    assert_equal 'Guest responded to A discussion', mail['subject'].to_s
  end

  test 'responding as a guest will notify the other subscribers' do
    user = create(:user, email: 'user-email@example.com')
    discussion = create(:discussion, user: user, title: 'A discussion')
    discussion.subscriptions.create(user: user)
    respond_as_guest_to(discussion)

    mail = ActionMailer::Base.deliveries.first
    assert_equal 'user-email@example.com', mail['to'].to_s
    assert_equal 'New response in Mybema community', mail['subject'].to_s
  end

  test 'responding as a guest will not notify subscribers that have unsubscribed' do
    user = create(:user, email: 'user-email@example.com')
    discussion = create(:discussion, user: user, title: 'A discussion')
    discussion.subscriptions.create(user: user, subscribed: false)
    respond_as_guest_to(discussion)

    mail = ActionMailer::Base.deliveries.first
    refute_equal 'user-email@example.com', mail['to'].to_s
    refute_equal 'New response in Mybema community', mail['subject'].to_s
  end

  test 'responding as a user will notify the other subscribers' do
    user = create(:user, email: 'other-user-email@example.com')
    discussion = create(:discussion, user: user, title: 'A discussion')
    discussion.subscriptions.create(user: user)
    sign_user_in
    visit discussion_path(discussion.slug)
    fill_in 'Have something to add?', with: 'This will notify the other subscribers'
    click_button 'Respond'

    mail = ActionMailer::Base.deliveries.first
    assert_equal 'other-user-email@example.com', mail['to'].to_s
    assert_equal 'New response in Mybema community', mail['subject'].to_s
  end

  test 'responding as a user will not notify the other subscribers that have unsubscribed' do
    user = create(:user, email: 'other-user-email@example.com')
    discussion = create(:discussion, user: user, title: 'A discussion')
    discussion.subscriptions.create(user: user, subscribed: false)
    sign_user_in
    visit discussion_path(discussion.slug)
    fill_in 'Have something to add?', with: 'This will not notify the other subscribers'
    click_button 'Respond'

    mail = ActionMailer::Base.deliveries.first
    refute_equal 'other-user-email@example.com', mail['to'].to_s
    refute_equal 'New response in Mybema community', mail['subject'].to_s
  end

  test 'responding as a user will not send an email notification to themselves' do
    user = create(:user, email: 'other-user-email@example.com')
    discussion = create(:discussion, user: user, title: 'A discussion')
    discussion.subscriptions.create(user: user, subscribed: false)
    sign_user_in
    visit discussion_path(discussion.slug)
    fill_in 'Have something to add?', with: 'This will not notify the other subscribers'
    click_button 'Respond'

    receiver_addresses = ActionMailer::Base.deliveries.map(&:to).flatten
    refute_includes receiver_addresses, 'bob@gmail.com'
  end

  test 'creating a discussion as a user will notify the admins' do
    create(:discussion_category, name: 'Cool category')
    sign_user_in
    visit root_path
    click_link 'Start a discussion'
    fill_in 'Add a title', with: 'A title'
    select 'Cool category', from: 'Choose category'
    fill_in 'Add your content', with: 'Some cool content'
    click_button 'add discussion'

    receiver_addresses = ActionMailer::Base.deliveries.map(&:to).flatten
    assert_includes receiver_addresses, 'admin-address@example.com'
  end

  test 'creating a discussion as a guest will notify the admins' do
    create(:discussion_category, name: 'Cool category')
    visit root_path
    click_link 'Start a discussion'
    fill_in 'Add a title', with: 'A title'
    select 'Cool category', from: 'Choose category'
    fill_in 'Add your content', with: 'Some cool content'
    click_button 'add discussion'

    receiver_addresses = ActionMailer::Base.deliveries.map(&:to).flatten
    assert_includes receiver_addresses, 'admin-address@example.com'
  end

  test 'responding as an admin will notify subscribers' do
    user = create(:user, email: 'other-user-email@example.com')
    discussion = create(:discussion, user: user, title: 'A discussion')
    discussion.subscriptions.create(user: user)
    sign_in_as_admin
    visit discussion_path(discussion.slug)
    fill_in 'Have something to add?', with: 'This will notify the other subscribers'
    click_button 'Respond'

    mail = ActionMailer::Base.deliveries.first
    assert_equal 'other-user-email@example.com', mail['to'].to_s
  end

  test 'responding as an admin will not notify the admins' do
    user = create(:user, email: 'other-user-email@example.com')
    discussion = create(:discussion, user: user, title: 'A discussion')
    discussion.subscriptions.create(user: user)
    sign_in_as_admin
    visit discussion_path(discussion.slug)
    fill_in 'Have something to add?', with: 'This will notify the other subscribers'
    click_button 'Respond'

    receiver_addresses = ActionMailer::Base.deliveries.map(&:to).flatten
    refute_includes receiver_addresses, 'admin@test.com'
  end
end