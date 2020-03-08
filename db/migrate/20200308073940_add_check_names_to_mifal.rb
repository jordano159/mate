class AddCheckNamesToMifal < ActiveRecord::Migration[5.2]
  def change
    add_column :mifals, :check_names, :text
  end
end
