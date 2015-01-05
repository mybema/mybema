class AddTitleToAppSettings < ActiveRecord::Migration
  def change
    add_column :app_settings, :community_title, :string, default: 'Mybema'
  end
end
