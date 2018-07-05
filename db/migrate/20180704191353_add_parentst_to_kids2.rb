class AddParentstToKids2 < ActiveRecord::Migration[5.2]
  def change
    add_column :kids, :parents, :string
  end
end
