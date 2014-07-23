class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :username
      t.string :ip_address
      t.string :guid
      t.boolean :banned, default: false

      t.timestamps
    end
  end
end
