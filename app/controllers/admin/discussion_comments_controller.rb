class Admin::DiscussionCommentsController < AdminsController
  def index
    @comments = DiscussionComment.all.reverse
  end
end