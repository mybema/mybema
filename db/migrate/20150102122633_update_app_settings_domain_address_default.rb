class UpdateAppSettingsDomainAddressDefault < ActiveRecord::Migration
  def change
    change_column :app_settings, :domain_address, :string, default: 'example.com'
  end
end