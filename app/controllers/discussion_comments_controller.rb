class DiscussionCommentsController < ApplicationController
  def create
    @comment = DiscussionComment.new comment_params

    if @current_user.can_contribute? && @comment.save
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
end