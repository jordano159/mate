class ChangeDateToString < ActiveRecord::Migration[5.2]
  def change
      change_column :checks, :date, :string
  end
end
