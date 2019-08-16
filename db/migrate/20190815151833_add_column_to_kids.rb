class AddColumnToKids < ActiveRecord::Migration[5.2]
  def change
    add_column :kids, :last_group, :integer
  end
end
