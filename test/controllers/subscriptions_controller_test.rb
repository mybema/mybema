require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase
  def setup
    create(:app_settings)
    create(:user, username: 'Guest')
    @user = create(:user, username: "joel")
    @discussion = create(:discussion, title: 'discussion')
    sign_in(:user, @user)
  end

  test "POST subscribe will redirect to discussion page" do
    post :subscribe, slug: 'discussion'
    assert_redirected_to discussion_path('discussion')
  end

  test "POST subscribe will subscribe the user" do
    post :subscribe, slug: 'discussion'
    assert_equal true, @discussion.subscriptions.where(user: @user).first.subscribed
  end

  test "POST unsubscribe will redirect to discussion page" do
    @discussion.subscriptions.create(user: @user)
    post :unsubscribe, slug: 'discussion'
    assert_redirected_to discussion_path('discussion')
  end

  test "POST unsubscribe will unsubscribe the user" do
    subscription = @discussion.subscriptions.create(user: @user, subscribed: true)
    post :unsubscribe, slug: 'discussion'
    assert_equal false, subscription.reload.subscribed
  end
end