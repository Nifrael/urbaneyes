class AddColumnsToNotifications < ActiveRecord::Migration[7.1]
  def change
    add_column :notifications, :notifiable_id, :integer
    add_column :notifications, :notifiable_type, :string
    add_column :notifications, :notifiable_content, :string
  end
end
