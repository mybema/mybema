class AddGuestIdToTables < ActiveRecord::Migration
  def change
    change_table :discussions do |t|
      t.string :guest_id
    end

    change_table :discussion_comments do |t|
      t.string :guest_id
    end
  end
end