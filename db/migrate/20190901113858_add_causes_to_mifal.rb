class AddCausesToMifal < ActiveRecord::Migration[5.2]
  def change
    add_column :mifals, :causes, :text
  end
end
