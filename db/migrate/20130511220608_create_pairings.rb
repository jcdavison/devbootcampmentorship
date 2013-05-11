class CreatePairings < ActiveRecord::Migration
  def change
    create_table :pairings do |t|
      t.integer :mentor_id
      t.integer :mentee_id

      t.timestamps
    end
    add_index :pairings, :mentor_id
    add_index :pairings, :mentee_id
    add_index :pairings, [:mentor_id, :mentee_id], unique: true
  end
end
