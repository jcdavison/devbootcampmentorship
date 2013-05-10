class AddAttributesToUser < ActiveRecord::Migration
  def up
    add_column :users, :contact_phone, :string
    add_column :users, :contact_email, :string
    add_column :users, :active, :boolean
    add_column :users, :deleted, :boolean
  end
end
