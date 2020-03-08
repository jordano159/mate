class AddHasOtherCheckNameToMifal < ActiveRecord::Migration[5.2]
  def change
    add_column :mifals, :has_other_check_name, :boolean, null: false, default: false
  end
end
