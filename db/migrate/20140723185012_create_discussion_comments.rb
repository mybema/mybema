class CreateDiscussionComments < ActiveRecord::Migration
  def change
    create_table :discussion_comments do |t|
      t.text :body
      t.boolean :hidden, default: false
      t.references :discussion, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
