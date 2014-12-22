class AddSeedLevelToAppSettings < ActiveRecord::Migration
  def change
    add_column :app_settings, :seed_level, :integer, default: 0
  end
end