class AddLeaveCauseToKid < ActiveRecord::Migration[5.2]
  def change
    add_column :kids, :leave_cause, :string
  end
end
