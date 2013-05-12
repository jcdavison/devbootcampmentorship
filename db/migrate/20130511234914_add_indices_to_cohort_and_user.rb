class AddIndicesToCohortAndUser < ActiveRecord::Migration
  def change
    add_index :users, :role
    add_index :cohorts, :start_date
    add_index :cohorts, :end_date
  end
end
