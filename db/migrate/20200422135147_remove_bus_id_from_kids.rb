class RemoveBusIdFromKids < ActiveRecord::Migration[5.2]
  def change
    remove_column :kids, :bus_id, :integer
  end
end
