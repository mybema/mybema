class UsersController < ApplicationController
  before_action :disallow_guest_users, except: :profile
  before_action :check_for_user, only: :profile
  before_action :redirect_from_guest_profile, only: :profile

  def edit_profile
  end

  def profile
    @user_discussions = @user.discussions.with_includes
    @user_responses = @user.discussion_comments.with_includes
  end

  def update_profile
    if @current_user.update_attributes(user_params)
      flash[:notice] = 'Your profile was updated'
      redirect_to profile_path
    else
      render action: "edit_profile"
    end
  end

  private

  def disallow_guest_users
    if @current_user.guest?
      flash[:alert] = 'You have to be signed in to do that.'
      redirect_to root_path
    end
  end

  def check_for_user
    username = params[:username].titleize.downcase
    query = User.arel_table

    unless @user = User.where(query[:username].matches(username)).first
      flash[:alert] = 'User not found'
      redirect_to root_path
    end
  end

  def redirect_from_guest_profile
    return redirect_to root_path if @user.guest?
  end

  def user_params
    params.require(:user).permit(:username, :email, :avatar, :bio)
  end
end