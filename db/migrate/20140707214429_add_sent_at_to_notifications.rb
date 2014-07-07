class AddSentAtToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :sent_at, :date
  end
end
