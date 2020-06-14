class AddFeverToKids < ActiveRecord::Migration[5.2]
  def change
    add_column :kids, :fever, :integer
  end
end
