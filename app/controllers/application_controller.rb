class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :initialize_app, :fetch_user_and_handle_guest_cookie

  def initialize_app
    @app ||= AppSettings.first
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      admin_path
    else
      root_path
    end
  end

  def fetch_user_and_handle_guest_cookie
    fetch_user
    fetch_or_assign_guest_cookie if @current_user.guest?
  end

  private

  def create_identicon(klass, object_id)
    IdenticonWorker.perform_async(klass, object_id) if @current_user.guest?
  end

  def fetch_or_assign_guest_cookie
    cookies.permanent[:mybema_guest_id] ||= SecureRandom.hex(32)
  end

  def fetch_user
    @current_user = current_user || User.where(username: 'Guest').first
  end
end