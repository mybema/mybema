class Admin::DiscussionCommentsController < AdminsController
  def index
    @comments = DiscussionComment.includes(:discussion).load.reverse
  end

  def edit
    @comment = DiscussionComment.find(params[:id])
  end

  def update
    @comment = DiscussionComment.find(params[:id])

    if @comment.update_attributes(comment_params)
      redirect_to admin_comments_path
    else
      render 'edit'
    end
  end

  def destroy
    @comment = DiscussionComment.find(params[:id])

    if @comment.destroy
      redirect_to admin_comments_path
    end
  end

  def toggle_visibility
    @comment = DiscussionComment.find(params[:id])

    if @comment.toggle!(:hidden)
      redirect_to edit_admin_comment_path
    end
  end

  private

  def comment_params
    params.require(:discussion_comment).permit(:body)
  end
end