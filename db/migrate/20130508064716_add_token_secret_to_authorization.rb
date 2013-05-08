class AddTokenSecretToAuthorization < ActiveRecord::Migration
  def up
    add_column :authorizations, :token, :string
    add_column :authorizations, :secret, :string
  end
  def down
    add_column :authorizations, :token, :string
    add_column :authorizations, :secret, :string
  end
end
