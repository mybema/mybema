class AdminNotificationWorker
  include Sidekiq::Worker

  def perform comment_id, user_id
    comment = DiscussionComment.find(comment_id)
    user    = User.find(user_id)

    MybemaDeviseMailer.notify_admins(comment, user).deliver_now
  end
end