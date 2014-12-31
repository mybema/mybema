class AddSmtpToAppSettings < ActiveRecord::Migration
  def change
    add_column :app_settings, :smtp_address, :string, default: ''
    add_column :app_settings, :smtp_port, :integer, default: 587
    add_column :app_settings, :smtp_domain, :string, default: ''
    add_column :app_settings, :smtp_username, :string, default: ''
    add_column :app_settings, :smtp_password, :string, default: ''
    add_column :app_settings, :mailer_sender, :string, default: 'change-me@example.com'
    add_column :app_settings, :mailer_reply_to, :string, default: 'change-me@example.com'
    add_column :app_settings, :welcome_mailer_copy, :string, default: "Hello {{USERNAME}}! \n\nThank you for signing up to our community!"
  end
end