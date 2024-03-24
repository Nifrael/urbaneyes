class AddUserToHubs < ActiveRecord::Migration[7.1]
  def change
    add_reference :hubs, :user, null: false, foreign_key: true
  end
end
