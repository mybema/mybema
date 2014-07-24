class DiscussionsController < ApplicationController
  before_action :fetch_categories, only: [:show, :index, :edit, :new]

  def index
    @discussions = Discussion.visible

    if params[:discussion_category_id]
      @category    = DiscussionCategory.find(params[:discussion_category_id])
      @discussions = @category.discussions
    end
  end

  def show
    @discussion = Discussion.find(params[:id])
  end

  private

  def fetch_categories
    @categories = DiscussionCategory.all
  end
end