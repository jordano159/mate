class ChangeDateToDate < ActiveRecord::Migration[5.2]
  def change
    remove_column :checks, :date
    add_column :checks, :date, :date
  end
end
