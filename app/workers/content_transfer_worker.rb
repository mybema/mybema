class ContentTransferWorker
  include Sidekiq::Worker

  def perform user_id, guest_id
    user = User.where(id: user_id).first
    return unless user # possibly already deleted account

    Discussion.where(guest_id: guest_id).each do |discussion|
      discussion.update_attributes(user_id: user_id, guest_id: nil)
    end

    DiscussionComment.where(guest_id: guest_id).each do |comment|
      comment.update_attributes!(user_id: user_id, guest_id: nil)
    end

    user.update_attributes(guid: guest_id)
  end
end