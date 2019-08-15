class ChangeAxesColumnName < ActiveRecord::Migration[5.2]
  def change
     rename_column :mifals, :axes_name, :axis_name
  end
end
