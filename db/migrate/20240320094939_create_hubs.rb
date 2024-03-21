class CreateHubs < ActiveRecord::Migration[7.1]
  def change
    create_table :hubs do |t|

      t.timestamps
    end
  end
end
