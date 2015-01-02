class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :app_settings, :fetch_user_and_handle_guest_cookie
  before_filter :configure_action_mailer_settings

  def app_settings
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
      :address              => app_settings.smtp_address,
      :port                 => app_settings.smtp_port,
      :domain               => app_settings.smtp_domain,
      :user_name            => app_settings.smtp_username,
      :password             => app_settings.smtp_password,
      :authentication       => "plain",
      :enable_starttls_auto => true
    }
    ActionMailer::Base.default_url_options[:host] = app_settings.domain_address
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