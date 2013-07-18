class Removecontactemailfromuser < ActiveRecord::Migration
  def up
    remove_column :users, :contact_email
  end

  def down
  end
end
