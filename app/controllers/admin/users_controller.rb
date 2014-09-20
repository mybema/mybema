class Admin::UsersController < AdminsController
  def index
    @users = User.includes(:discussions, :discussion_comments).load.sort_by(&:created_at)
  end
end