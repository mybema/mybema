class SubscriptionManagerService
  def initialize(discussion, subscriber, email=nil)
    @discussion = discussion
    @subscriber = subscriber
    @email = email
  end

  def subscribe
    if @subscriber.logged_in?
      handle_subscription
    else
      subscribe_guest
    end
  end

  def subscribe_via_comment
    unless actively_unsubscribed
      subscribe
    end
  end

  def unsubscribe
    subscription = @subscriber.subscriptions.where(discussion: @discussion).first
    subscription.toggle!(:subscribed)
  end

  private

  def actively_unsubscribed
    @subscriber.subscriptions.where(discussion: @discussion, subscribed: false).any?
  end

  def handle_subscription
    subscription = @subscriber.subscriptions.where(discussion: @discussion).first

    if subscription
      subscription.toggle!(:subscribed)
    else
      @subscriber.subscriptions.create(discussion: @discussion)
    end
  end

  def subscribe_guest
    return if @email.blank?

    unless Subscription.where(discussion: @discussion, guest_email: @email).any?
      Subscription.create(discussion: @discussion, guest_email: @email)
    end
  end
end