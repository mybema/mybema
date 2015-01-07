class AddCustomizationsToAppSettings < ActiveRecord::Migration
  def change
    add_column :app_settings, :nav_bg_color, :string, default: '#333'
    add_column :app_settings, :nav_link_color, :string, default: '#FFF'
    add_column :app_settings, :nav_link_hover_color, :string, default: '#212121'
  end
end