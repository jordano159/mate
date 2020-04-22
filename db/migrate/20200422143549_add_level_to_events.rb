class AddLevelToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :level, :integer
  end
end
