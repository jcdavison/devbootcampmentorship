class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :twitter, :string
    add_column :users, :company, :string
    add_column :users, :linkedin, :string
    add_column :users, :location, :string
  end
end
