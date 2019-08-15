class AddDateToChecks < ActiveRecord::Migration[5.2]
  def change
    add_column :checks, :date, :date
  end
end
