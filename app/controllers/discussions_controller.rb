class DiscussionsController < ApplicationController
  before_action :fetch_categories, only: [:show, :index, :edit, :new]

  def index
    if slug = params[:category]
      @category = DiscussionCategory.where(slug: slug).first
      @discussions = Discussion.where(discussion_category: @category).with_includes.visible.by_recency
    else
      @discussions = Discussion.with_includes.visible.by_recency
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
      @categories = DiscussionCategory.all
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