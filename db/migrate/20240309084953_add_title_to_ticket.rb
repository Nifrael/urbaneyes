class AddTitleToTicket < ActiveRecord::Migration[7.1]
  def change
    add_column :tickets, :title, :string
  end
end
