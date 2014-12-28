class AddDomainAddressToAppSettings < ActiveRecord::Migration
  def change
    add_column :app_settings, :domain_address, :string
  end
end