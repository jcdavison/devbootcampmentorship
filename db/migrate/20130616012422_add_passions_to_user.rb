class AddPassionsToUser < ActiveRecord::Migration
  def change
    add_column :users, :passions, :text
    add_column :users, :interests, :text
  end
end
