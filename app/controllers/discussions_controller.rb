class DiscussionsController < ApplicationController
  def index
    @discussions = Discussion.visible

    if params[:discussion_category_id]
      @category    = DiscussionCategory.find(params[:discussion_category_id])
      @discussions = @category.discussions
    end
  end
end