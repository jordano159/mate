class AddIndexToStaffs < ActiveRecord::Migration[5.2]
  def change
    add_index :staffs, :name
  end
end
