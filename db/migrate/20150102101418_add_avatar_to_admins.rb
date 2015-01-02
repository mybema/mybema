class AddAvatarToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :avatar, :string
  end
end