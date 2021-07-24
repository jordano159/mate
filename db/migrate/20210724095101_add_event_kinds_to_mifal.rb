class AddEventKindsToMifal < ActiveRecord::Migration[5.2]
  def change
    add_column :mifals, :event_kinds, :text
    change_column :events, :kind, :text
  end
end
