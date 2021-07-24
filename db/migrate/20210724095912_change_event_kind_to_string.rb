class ChangeEventKindToString < ActiveRecord::Migration[5.2]
  def change
    change_column :events, :kind, :string
  end
end
