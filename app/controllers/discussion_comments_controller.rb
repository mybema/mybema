class DiscussionCommentsController < ApplicationController
  def create
    @comment = DiscussionComment.new comment_params

    if (@current_user.can_contribute? || current_admin) && @comment.save
      handle_discussion_subscription
      send_email_notifications
      flash[:notice] = 'Your response was added'
      create_identicon('DiscussionComment', @comment.id)
      redirect_to discussion_path(@comment.discussion.slug)
    else
      flash[:alert] = 'Your response could not be added'
      redirect_to discussion_path(@comment.discussion.slug)
    end
  end

  private

  def comment_params
    params.require(:discussion_comment).permit(:body, :user_id, :admin_id, :discussion_id, :guest_id, :humanizer_answer, :humanizer_question_id)
  end

  def handle_discussion_subscription
    guest_email = params[:guest_email]
    SubscriptionManagerService.new(@comment.discussion, @current_user, guest_email).subscribe_via_comment
  end

  def send_email_notifications
    attributes = { comment: @comment, user: @current_user, admin: current_admin }
    service = NotificationService.new(attributes)
    service.deliver_notifications
    service.notify_admins
  end
end