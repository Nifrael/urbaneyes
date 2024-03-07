class ChangeLocationToAddress < ActiveRecord::Migration[7.1]
  def change
    rename_column :tickets, :location, :address
  end
end
