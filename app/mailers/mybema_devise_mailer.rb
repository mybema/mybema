class MybemaDeviseMailer < Devise::Mailer
  before_filter :use_smtp_settings

  def invitation_instructions(record, token, opts={})
    opts[:from] = AppSettings.first.mailer_sender
    opts[:reply_to] = AppSettings.first.mailer_reply_to
    @token = token
    devise_mail(record, :invitation_instructions, opts)
  end

  def confirmation_instructions(record, token, opts={})
    @token = token
    opts[:from] = AppSettings.first.mailer_sender
    opts[:reply_to] = AppSettings.first.mailer_reply_to
    devise_mail(record, :confirmation_instructions, opts)
  end

  def reset_password_instructions(record, token, opts={})
    @token = token
    opts[:from] = AppSettings.first.mailer_sender
    opts[:reply_to] = AppSettings.first.mailer_reply_to
    devise_mail(record, :reset_password_instructions, opts)
  end

  def send_welcome(record)
    @resource = record
    mail(to: record.email,
         from: AppSettings.first.mailer_sender,
         template_path: "devise/mailer",
         subject: "Welcome to the community!")
  end

  def unlock_instructions(record, token, opts={})
    @token = token
    opts[:from] = AppSettings.first.mailer_sender
    opts[:reply_to] = AppSettings.first.mailer_reply_to
    devise_mail(record, :unlock_instructions, opts)
  end

  private

  def use_smtp_settings
    default_url_options[:host] = AppSettings.first.domain_address
    smtp_settings = {
      :address              => AppSettings.first.smtp_address,
      :port                 => AppSettings.first.smtp_port,
      :domain               => AppSettings.first.smtp_domain,
      :user_name            => AppSettings.first.smtp_username,
      :password             => AppSettings.first.smtp_password,
      :authentication       => "plain",
      :enable_starttls_auto => true
    }
  end
end