class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :user
      t.references :discussion
      t.string :guest_email
      t.boolean :subscribed, default: true

      t.timestamps null: false
    end
  end
end
