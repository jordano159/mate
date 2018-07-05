class RemoveParentFromKids < ActiveRecord::Migration[5.2]
  def change
    remove_column :kids, :parents, :boolean
  end
end
