class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :initialize_app, :fetch_user_and_handle_guest_cookie
  before_filter :configure_action_mailer_settings

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

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  private

  def configure_action_mailer_settings
    ActionMailer::Base.smtp_settings = {
      :address              => AppSettings.first.smtp_address,
      :port                 => AppSettings.first.smtp_port,
      :domain               => AppSettings.first.smtp_domain,
      :user_name            => AppSettings.first.smtp_username,
      :password             => AppSettings.first.smtp_password,
      :authentication       => "plain",
      :enable_starttls_auto => true
    }
    ActionMailer::Base.default_url_options[:host] = AppSettings.first.domain_address
  end

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