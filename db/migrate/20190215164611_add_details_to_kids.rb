class AddDetailsToKids < ActiveRecord::Migration[5.2]
  def change
    add_column :kids, :grade, :string
    add_index :kids, :grade
    add_column :kids, :taz, :integer
    add_index :kids, :taz
    rename_column :kids, :dad, :parent_1
    rename_column :kids, :dad_phone, :parent_1_phone
    rename_column :kids, :mom, :parent_2
    rename_column :kids, :mom_phone, :parent_2_phone
  end
end
