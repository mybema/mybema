class CreateGuidelines < ActiveRecord::Migration
  def change
    create_table :guidelines do |t|
      t.string :name
      t.timestamps
    end
  end
end