class AddAdminToDiscussions < ActiveRecord::Migration
  def change
    add_column :discussions, :admin_id, :integer, index: true
  end
end