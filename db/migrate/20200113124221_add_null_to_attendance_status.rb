class AddNullToAttendanceStatus < ActiveRecord::Migration[5.2]
  def change
    change_column_null :attendances, :status, true
  end
end
