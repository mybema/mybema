class AddGoogleAnalyticsToAppSettings < ActiveRecord::Migration
  def change
    add_column :app_settings, :ga_code, :string
  end
end