class AddStatusAndLeaveCauseToKidGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :kid_groups, :status, :integer
    add_column :kid_groups, :leave_cause, :string
  end
end
