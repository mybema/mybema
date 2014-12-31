class MybemaDeviseMailer < Devise::Mailer
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
end