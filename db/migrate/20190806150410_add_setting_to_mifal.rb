class AddSettingToMifal < ActiveRecord::Migration[5.2]
  def change
    add_column :mifals, :has_buses, :boolean, null: false, default: false
    add_column :mifals, :has_events, :boolean, null: false, default: false
    add_column :mifals, :has_axes, :boolean, null: false, default: false
    add_column :mifals, :has_approve, :boolean, null: false, default: false
    add_column :mifals, :has_late, :boolean, null: false, default: false
    add_column :mifals, :group_name, :text
    add_column :mifals, :head_name, :text
    add_column :mifals, :axes_name, :text
    add_column :mifals, :columns, :text
  end
end
