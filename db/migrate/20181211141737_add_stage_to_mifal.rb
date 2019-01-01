class AddStageToMifal < ActiveRecord::Migration[5.2]
  def change
    add_column :mifals, :stage, :integer
  end
end
