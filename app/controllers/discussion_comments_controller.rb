class DiscussionCommentsController < ApplicationController
  def create
    @comment = DiscussionComment.new comment_params

    if @comment.save
      redirect_to discussion_path(@comment.discussion)
    else
      redirect_to discussion_path(@comment.discussion)
    end
  end

  private

  def comment_params
    params.require(:discussion_comment).permit(:body, :user_id, :admin_id, :discussion_id)
  end
end