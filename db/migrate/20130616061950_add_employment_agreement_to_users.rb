class AddEmploymentAgreementToUsers < ActiveRecord::Migration
  def up
    add_column :users, :employment_agreement, :boolean
  end

  def down
    remove_column :users, :employment_agreement, :boolean
  end
end
