class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :fetch_user

  def fetch_user
    @current_user = current_user || User.where(username: 'Guest').first
  end
end
