class AddColumnsToMifal < ActiveRecord::Migration[5.2]
  def change
    add_column :mifals, :checks_num, :boolean, null: false, default: false
    add_column :mifals, :guide_name, :text
    add_column :mifals, :head_head_name, :text
  end
end
