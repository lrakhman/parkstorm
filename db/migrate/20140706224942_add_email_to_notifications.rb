class AddEmailToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :email, :string
  end
end
