class AddNullToKidStatus < ActiveRecord::Migration[5.2]
  def change
    change_column_null :kids, :status, true
  end
end
