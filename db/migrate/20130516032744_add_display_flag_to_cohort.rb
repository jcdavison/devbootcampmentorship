class AddDisplayFlagToCohort < ActiveRecord::Migration
  def change
    add_column :cohorts, :display, :boolean, :default => false
    Cohort.find_each do |c|
      c.display = false
      c.save
    end
  end
end
