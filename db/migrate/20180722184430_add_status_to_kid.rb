class AddStatusToKid < ActiveRecord::Migration[5.2]
  def change
    add_column :kids, :status, :integer, default: 0
  end
end
