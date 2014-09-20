class Admin::DiscussionCommentsController < AdminsController
  def index
    @comments = DiscussionComment.includes(:discussion).load.reverse
  end
end