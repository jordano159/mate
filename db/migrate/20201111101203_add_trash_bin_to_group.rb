class AddTrashBinToGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :trash_bin, :integer
  end
end
