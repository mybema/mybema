class UserNotificationWorker
  include Sidekiq::Worker

  def perform discussion_id, subscribers
    discussion = Discussion.find(discussion_id)
    MybemaDeviseMailer.notify_subscribers(discussion, subscribers).deliver_now
  end
end