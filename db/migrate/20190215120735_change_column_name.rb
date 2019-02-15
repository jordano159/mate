class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :mifals, :wizard, :bus_proposal
  end
end
