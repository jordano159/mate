class ChangeTazToBigInt < ActiveRecord::Migration[5.2]
  def change
      change_column :kids, :taz, :bigint
  end
end
