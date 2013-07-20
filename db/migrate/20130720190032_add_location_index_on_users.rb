class AddLocationIndexOnUsers < ActiveRecord::Migration
  def up
    add_index :users, :location_id, :name => "index_users_on_location_id"
    add_index :cohorts, :location_id, :name => "index_cohorts_on_location_id"
    add_index :locations, :name, :name => "index_locations_on_name"
  end

  def down
    remove_index :users, :name => "index_users_on_location_id"
    remove_index :cohorts, :name => "index_cohorts_on_location_id"
    remove_index :locations, :name => "index_locations_on_name"
  end
end
