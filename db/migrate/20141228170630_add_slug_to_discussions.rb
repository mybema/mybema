class AddSlugToDiscussions < ActiveRecord::Migration
  def change
    add_column :discussions, :slug, :string
  end
end