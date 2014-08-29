class AddAdminsToDiscussionComments < ActiveRecord::Migration
  def change
    change_table :discussion_comments do |t|
      t.references :admin, index: true
    end
  end
end