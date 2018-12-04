class DropRpushTables < ActiveRecord::Migration[5.2]
  def up
    drop_table :rpush_feedback
    drop_table :rpush_notifications
    drop_table :rpush_apps
  end
  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
