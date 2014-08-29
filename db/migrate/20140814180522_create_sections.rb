class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :title
      t.integer :articles_count, default: 0

      t.timestamps
    end
  end
end