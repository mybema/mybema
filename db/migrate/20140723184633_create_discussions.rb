class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      t.text :body
      t.string :title
      t.boolean :hidden, default: false
      t.references :discussion_category, index: true
      t.references :user, index: true
      t.integer :discussion_comments_count, default: 0

      t.timestamps
    end
  end
end
