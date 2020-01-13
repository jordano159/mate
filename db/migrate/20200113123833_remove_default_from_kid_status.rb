class RemoveDefaultFromKidStatus < ActiveRecord::Migration[5.2]
  def change
    change_column_default :kids, :status, nil
  end
end
