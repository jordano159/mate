class AddIndexToKids < ActiveRecord::Migration[5.2]
  def change
    add_index :kids, :name
    add_index :kids, :last_name
    add_index :kids, :sex
    add_index :kids, :phone
    add_index :kids, :medical
    add_index :kids, :meds
    add_index :kids, :food
    add_index :kids, :city
    add_index :kids, :ken
    add_index :kids, :dad
    add_index :kids, :dad_phone
    add_index :kids, :mom
    add_index :kids, :mom_phone
    add_index :kids, :size
    add_index :kids, :group_id
    add_index :kids, :shabat
    add_index :kids, :parents
    add_index :kids, :swim
    add_index :kids, :exits
    add_index :kids, :comments
  end
end
