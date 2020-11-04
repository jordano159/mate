class EditKidColumns < ActiveRecord::Migration[5.2]
  def change
    rename_column :kids, :cause, :causes
    change_column :kids, :status, :text
    rename_column :kids, :status, :statuses
  end
end
