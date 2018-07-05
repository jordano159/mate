class RemoveShabatFromKids < ActiveRecord::Migration[5.2]
  def change
    remove_column :kids, :shabat, :boolean
  end
end
