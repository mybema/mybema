class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.text :body
      t.string :title
      t.references :section, index: true

      t.timestamps
    end
  end
end