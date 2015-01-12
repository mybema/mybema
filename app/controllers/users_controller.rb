class UsersController < ApplicationController
  before_action :disallow_guest_users, except: :profile

  def edit_profile
  end

  def profile
    if @user = User.where(username: params[:username]).first
      @user_discussions = @user.discussions.with_includes
    else
      flash[:alert] = 'User not found'
      redirect_to root_path
    end
  end

  def update_profile
    if @current_user.update_attributes(user_params)
      flash[:notice] = 'Your profile was updated'
      redirect_to profile_path
    else
      render action: "profile"
    end
  end

  private

  def disallow_guest_users
    if @current_user.guest?
      flash[:alert] = 'You have to be signed in to do that.'
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:username, :email, :avatar, :bio)
  end
end