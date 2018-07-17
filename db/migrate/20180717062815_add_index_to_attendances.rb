class AddIndexToAttendances < ActiveRecord::Migration[5.2]
  def change
    add_index :attendances, :kid_id
    add_index :attendances, :check_id
    add_index :attendances, :status
    add_index :attendances, :cause
  end
end
