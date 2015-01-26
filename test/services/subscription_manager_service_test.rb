require 'test_helper'

class SubscriptionManagersServiceTest < ActiveSupport::TestCase
  test "#subscribe will create a new subscription for a user if one does not exist" do
    discussion = create(:discussion)
    user       = create(:user)

    service = SubscriptionManagerService.new(discussion, user)
    service.subscribe
    assert_equal Subscription.last.user, user
  end

  test "#subscribe will not create another subscription for a user if one already exists" do
    discussion = create(:discussion)
    user       = create(:user)

    discussion.subscriptions.create(user: user)
    service = SubscriptionManagerService.new(discussion, user)
    service.subscribe
    assert_equal 1, Subscription.count
  end

  test '#subscribe will subscribe the guest if an email address is provided' do
    discussion = create(:discussion)
    guest      = create(:user, username: 'Guest')

    service = SubscriptionManagerService.new(discussion, guest, 'guest@example.com')
    service.subscribe
    assert_equal Subscription.last.guest_email, 'guest@example.com'
  end

  test '#subscribe does nothing if guest did not provide an email address' do
    discussion = create(:discussion)
    guest      = create(:user, username: 'Guest')

    service = SubscriptionManagerService.new(discussion, guest)
    service.subscribe
    assert_equal 0, Subscription.count
  end

  test '#subscribe will not create an additional subscription for a guest if one already exists' do
    discussion = create(:discussion)
    guest      = create(:user, username: 'Guest')

    discussion.subscriptions.create(guest_email: 'guest@example.com')
    service = SubscriptionManagerService.new(discussion, guest, 'guest@example.com')
    service.subscribe
    assert_equal 1, Subscription.count
  end

  test '#subscribe_via_comment will do nothing if a user has a disabled subscription already' do
    discussion = create(:discussion)
    user       = create(:user)

    discussion.subscriptions.create(user: user, subscribed: false)
    service = SubscriptionManagerService.new(discussion, user)
    service.subscribe_via_comment
    assert_equal false, Subscription.last.subscribed
  end

  test '#subscribe_via_comment will create a subscription if none exists for the user yet' do
    discussion = create(:discussion)
    user       = create(:user)

    service = SubscriptionManagerService.new(discussion, user)
    service.subscribe_via_comment
    assert_equal 1, Subscription.count
  end

  test '#unsubscribe will set the subscribed status of a user subscription to false' do
    discussion = create(:discussion)
    user       = create(:user)

    discussion.subscriptions.create(user: user)
    service = SubscriptionManagerService.new(discussion, user)
    service.unsubscribe
    assert_equal false, Subscription.last.subscribed
  end
end