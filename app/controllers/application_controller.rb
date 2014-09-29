class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :fetch_user

  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      admin_path
    else
      root_path
    end
  end

  def fetch_user
    @current_user = current_user || User.where(username: 'Guest').first
  end
end