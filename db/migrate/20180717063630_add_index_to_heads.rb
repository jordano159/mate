class AddIndexToHeads < ActiveRecord::Migration[5.2]
  def change
    add_index :heads, :name
    add_index :heads, :axis_id
  end
end
