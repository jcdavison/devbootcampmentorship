class AddPicToUser < ActiveRecord::Migration
  def up
    add_column :users, :pic, :string
  end

  def down
    remove_column :users, :pic
  end
end
