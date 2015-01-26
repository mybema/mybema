class DiscussionCreationNotificationWorker
  include Sidekiq::Worker

  def perform discussion_id, user_id
    discussion = Discussion.find(discussion_id)
    user       = User.find(user_id)

    MybemaDeviseMailer.notify_admins_of_new_discussion(discussion, user).deliver_now
  end
end