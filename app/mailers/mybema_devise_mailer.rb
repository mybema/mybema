class MybemaDeviseMailer < Devise::Mailer
  before_filter :set_default_host

  def invitation_instructions(record, token, opts={})
    set_email_opts(opts, token)
    devise_mail(record, :invitation_instructions, opts)
  end

  def confirmation_instructions(record, token, opts={})
    set_email_opts(opts, token)
    devise_mail(record, :confirmation_instructions, opts)
  end

  def reset_password_instructions(record, token, opts={})
    set_email_opts(opts, token)
    devise_mail(record, :reset_password_instructions, opts)
  end

  def send_welcome(record)
    @resource = record
    mail(to: record.email,
         from: AppSettings.first.mailer_sender,
         template_path: "devise/mailer",
         subject: "Welcome to the community!",
         delivery_method_options: app_smtp_settings)
  end

  def unlock_instructions(record, token, opts={})
    set_email_opts(opts, token)
    devise_mail(record, :unlock_instructions, opts)
  end

  private

  def set_email_opts opts, token
    opts[:from] = AppSettings.first.mailer_sender
    opts[:reply_to] = AppSettings.first.mailer_reply_to
    opts[:delivery_method_options] = app_smtp_settings

    @token = token
  end

  def set_default_host
    default_url_options[:host] = smtp_settings.domain_address
  end

  def smtp_settings
    @app_settings || AppSettings.first
  end

  def app_smtp_settings
    self.smtp_settings = {
      address:              smtp_settings.smtp_address,
      port:                 smtp_settings.smtp_port,
      domain:               smtp_settings.smtp_domain,
      user_name:            smtp_settings.smtp_username,
      password:             smtp_settings.smtp_password,
      authentication:       "plain",
      enable_starttls_auto: true
    }
  end
end