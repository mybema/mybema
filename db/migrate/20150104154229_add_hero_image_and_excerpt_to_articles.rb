class AddHeroImageAndExcerptToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :excerpt, :string
    add_column :articles, :hero_image, :string
  end
end