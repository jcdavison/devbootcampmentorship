class AddRepoToUsers < ActiveRecord::Migration
  def up
    add_column :users, :repo, :string
  end
  def down
    remove_column :users, :repo, :string
  end
end
