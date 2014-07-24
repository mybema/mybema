class DiscussionsController < ApplicationController
  before_action :fetch_categories, only: [:show, :index, :edit, :new]

  def index
    @discussions = Discussion.visible

    if params[:discussion_category_id]
      @category    = DiscussionCategory.find(params[:discussion_category_id])
      @discussions = @category.discussions
    end
  end

  def new
    @discussion = Discussion.new
  end

  def edit
    @discussion = Discussion.find(params[:id])
  end

  def create
    @discussion = Discussion.new discussion_params

    if @discussion.save
      redirect_to discussion_path(@discussion)
    else
      render 'new'
    end
  end

  def show
    @discussion = Discussion.find(params[:id])
  end

  def update
    @discussion = Discussion.find(params[:id])
    @discussion.update_attributes discussion_params
  end

  private

  def fetch_categories
    @categories = DiscussionCategory.all
  end

  def discussion_params
    params.require(:discussion).permit(:body, :title, :user_id, :discussion_category_id)
  end
end