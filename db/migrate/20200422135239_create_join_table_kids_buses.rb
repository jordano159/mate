class CreateJoinTableKidsBuses < ActiveRecord::Migration[5.2]
  def change
    create_join_table :kids, :buses do |t|
      # t.index [:kid_id, :bus_id]
      # t.index [:bus_id, :kid_id]
    end
  end
end
