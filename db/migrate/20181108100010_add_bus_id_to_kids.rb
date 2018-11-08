class AddBusIdToKids < ActiveRecord::Migration[5.2]
  def change
    add_column :kids, :bus_id, :integer
  end
end
