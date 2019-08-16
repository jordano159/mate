class AddHardNameToGroupHeadAxis < ActiveRecord::Migration[5.2]
  def change
  tables = [:groups, :heads, :axes]

  tables.each do |table_name|
    add_column table_name, :hard_name, :string
    end
  end
end
