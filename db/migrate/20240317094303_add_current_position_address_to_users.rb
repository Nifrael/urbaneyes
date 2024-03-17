class AddCurrentPositionAddressToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :current_position_address, :string
  end
end
