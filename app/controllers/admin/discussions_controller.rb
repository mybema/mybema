class Admin::DiscussionsController < AdminsController
  def index
    @discussions = Discussion.by_recency
  end
end