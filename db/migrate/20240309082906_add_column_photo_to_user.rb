class AddColumnPhotoToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :photo, :string
  end
end
