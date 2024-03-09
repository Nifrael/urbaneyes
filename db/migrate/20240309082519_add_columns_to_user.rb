class AddColumnsToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :address, :string
    add_column :users, :role, :string
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
  end
end
