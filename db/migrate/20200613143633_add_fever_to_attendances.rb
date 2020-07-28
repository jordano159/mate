class AddFeverToAttendances < ActiveRecord::Migration[5.2]
  def change
    add_column :attendances, :fever, :integer
  end
end
