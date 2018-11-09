class AddBusIdToChecks < ActiveRecord::Migration[5.2]
  def change
    add_column :checks, :bus_id, :integer
  end
end
