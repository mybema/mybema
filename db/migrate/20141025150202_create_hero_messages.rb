class CreateHeroMessages < ActiveRecord::Migration
  def change
    create_table :hero_messages do |t|
      t.text :message
      t.timestamps
    end
  end
end