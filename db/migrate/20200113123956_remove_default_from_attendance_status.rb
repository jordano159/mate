class RemoveDefaultFromAttendanceStatus < ActiveRecord::Migration[5.2]
  def change
    change_column_default :attendances, :status, nil
  end
end
