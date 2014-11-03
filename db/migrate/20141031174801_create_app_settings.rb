class CreateAppSettings < ActiveRecord::Migration
  def change
    create_table :app_settings do |t|
      t.string :all_articles_img
      t.string :all_discussions_img
      t.string :join_community_img
      t.string :new_discussion_img
      t.string :logo
      t.text   :hero_message
      t.timestamps
    end
  end
end