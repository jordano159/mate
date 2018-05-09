class AddHeadAssociationToAxis < ActiveRecord::Migration[5.2]
  def change
    add_column :heads, :axis_id, :integer
  end
end
