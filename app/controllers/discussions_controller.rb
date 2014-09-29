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
    @guidelines = Guideline.all.reverse
  end

  def edit
    @discussion = Discussion.find(params[:id])
  end

  def create
    @discussion = Discussion.new discussion_params

    if @discussion.save
      flash[:notice] = 'Your discussion has been added'
      redirect_to discussion_path(@discussion)
    else
      @categories = DiscussionCategory.all
      @guidelines = Guideline.all.reverse
      flash[:alert] = 'Your discussion could not be created'
      render 'new'
    end
  end

  def show
    @discussion = Discussion.find(params[:id])
    @admin_id   = current_admin.id if current_admin
    @comments   = @discussion.discussion_comments

    if @discussion.hidden? && @admin_id == nil
      flash[:alert] = 'This discussion is not available anymore'
      redirect_to discussions_path
    end
  end

  def update
    @discussion = @current_user.discussions.where(id: params[:id]).first

    if @discussion && @discussion.update_attributes(discussion_params)
      flash[:notice] = 'Your discussion has been updated'
      redirect_to discussion_path(@discussion)
    else
      flash[:alert] = 'This discussion could not be updated'
      render 'edit'
    end
  end

  private

  def fetch_categories
    @categories = DiscussionCategory.all
  end

  def discussion_params
    params.require(:discussion).permit(:body, :title, :user_id, :discussion_category_id)
  end
end