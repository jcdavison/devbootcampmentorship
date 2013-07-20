class AddLeagueToUsersAndCohorts < ActiveRecord::Migration
  def up
    add_column :users, :location_id, :integer
    add_column :cohorts, :location_id, :integer
    l = Location.create(name: "San Francisco")
    c = Location.create(name: "Chicago")
    User.find_each do |u|
      u.location_id = l.id if u.location == "San Francisco"
      u.location_id = c.id if u.location == "Chicago"
      u.save
    end
    Cohort.find_each do |cohort|
      cohort.location = l
      cohort.save
    end
    remove_column :users, :location
  end

  def down
    remove_column :users, :location_id
    remove_column :cohort, :location_id
    add_column :users, :location, :string
  end
end
