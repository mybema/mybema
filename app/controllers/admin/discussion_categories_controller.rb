class Admin::DiscussionCategoriesController < AdminsController
  def index
    @categories = DiscussionCategory.all
  end

  def new
    @category = DiscussionCategory.new
  end

  def create
    @category = DiscussionCategory.new params.require(:discussion_category).permit(:name)

    if @category.save
      flash[:alert] = 'Your category has been added'
      redirect_to admin_discussion_categories_path
    else
      render 'new'
    end
  end

  def edit
    @category = DiscussionCategory.find(params[:id])
  end

  def update
    @category = DiscussionCategory.find(params[:id])

    if @category.update_attributes(discussion_category_params)
      flash[:alert] = 'Your category has been updated'
      redirect_to admin_discussion_categories_path
    else
      render 'edit'
    end
  end

  def destroy
    @category = DiscussionCategory.find(params[:id])

    if @category.destroy
      redirect_to admin_discussion_categories_path
    end
  end

  private

  def discussion_category_params
    params.require(:discussion_category).permit(:name)
  end
end