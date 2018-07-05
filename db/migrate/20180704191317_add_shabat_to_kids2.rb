class AddShabatToKids2 < ActiveRecord::Migration[5.2]
  def change
    add_column :kids, :shabat, :string
  end
end
