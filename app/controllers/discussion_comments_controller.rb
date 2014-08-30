class DiscussionCommentsController < ApplicationController
  def create
    @comment = DiscussionComment.new comment_params

    if @comment.save
      redirect_to discussion_path(@comment.discussion)
    else
      @discussion = @comment.discussion
      render 'new'
    end
  end

  private

  def comment_params
    params.require(:discussion_comment).permit(:body, :user_id, :discussion_id)
  end
end