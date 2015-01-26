class NotificationService
  def initialize(opts)
    @comment      = opts[:comment]
    @current_user = opts[:user]
    @admin        = opts[:admin]
    @discussion   = opts[:discussion] || @comment.discussion
  end

  def deliver_notifications
    subscribers = @discussion.subscriptions.where(subscribed: true).map(&:user_id).compact
    subscribers.delete(@current_user.id)
    UserNotificationWorker.perform_async(@discussion.id, subscribers) if subscribers.any?
  end

  def notify_admins
    return if @admin
    AdminNotificationWorker.perform_async(@comment.id, @current_user.id)
    true
  end

  def notify_admins_of_new_discussion
    return if @admin
    DiscussionCreationNotificationWorker.perform_async(@discussion.id, @current_user.id)
    true
  end
end