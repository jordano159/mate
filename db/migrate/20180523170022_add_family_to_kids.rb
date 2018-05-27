class AddFamilyToKids < ActiveRecord::Migration[5.2]
  def change
    add_column :kids, :last_name, :string
    add_column :kids, :sex, :string
    add_column :kids, :phone, :string
    add_column :kids, :medical, :string
    add_column :kids, :meds, :string
    add_column :kids, :food, :string
    add_column :kids, :city, :string
    add_column :kids, :ken, :string
    add_column :kids, :dad, :string
    add_column :kids, :dad_phone, :string
    add_column :kids, :mom, :string
    add_column :kids, :mom_phone, :string
    add_column :kids, :size, :string
  end
end
