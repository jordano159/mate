class AddKindToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :kind, :integer
  end
end
