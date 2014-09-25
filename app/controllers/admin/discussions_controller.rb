class Admin::DiscussionsController < AdminsController
  def index
    @discussions = Discussion.by_recency
  end

  def edit
    @discussion = Discussion.find(params[:id])
    @categories = DiscussionCategory.all
  end

  def update
    @discussion = Discussion.find(params[:id])

    if @discussion.update_attributes(discussion_params)
      redirect_to admin_discussions_path
    else
      @categories = DiscussionCategory.all
      render 'edit'
    end
  end

  def destroy
    @discussion = Discussion.find(params[:id])

    if @discussion.destroy
      redirect_to admin_discussions_path
    end
  end

  private

  def discussion_params
    params.require(:discussion).permit(:title, :body, :discussion_category_id)
  end
end