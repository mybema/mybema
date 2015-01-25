class AddEmailTokenToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :email_token, :string
  end
end