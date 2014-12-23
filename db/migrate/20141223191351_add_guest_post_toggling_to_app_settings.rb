class AddGuestPostTogglingToAppSettings < ActiveRecord::Migration
  def change
    add_column :app_settings, :guest_posting, :boolean, default: true
  end
end