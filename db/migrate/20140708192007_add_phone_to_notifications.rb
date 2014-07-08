class AddPhoneToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :phone, :string
  end
end
