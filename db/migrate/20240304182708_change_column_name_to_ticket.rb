class ChangeColumnNameToTicket < ActiveRecord::Migration[7.1]
  def change
    rename_column :tickets, :type, :category
  end
end
