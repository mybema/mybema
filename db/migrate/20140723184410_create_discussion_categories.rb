class CreateDiscussionCategories < ActiveRecord::Migration
  def change
    create_table :discussion_categories do |t|
      t.string :name
      t.string :slug
      t.text :description
      t.integer :discussions_count, default: 0

      t.timestamps
    end

    add_index :discussion_categories, :slug, unique: true
    add_index :discussion_categories, :name, unique: true
  end
end
