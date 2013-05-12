class CreateCommitments < ActiveRecord::Migration
  def change
    create_table :commitments do |t|
      t.integer :user_id
      t.integer :cohort_id

      t.timestamps
    end
    add_index :commitments, :user_id
    add_index :commitments, :cohort_id
    add_index :commitments, [:user_id, :cohort_id]
  end
end
