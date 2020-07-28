class AddCheckFeverToMifal < ActiveRecord::Migration[5.2]
  def change
    add_column :mifals, :check_fever, :boolean, null: false, default: false
  end
end
