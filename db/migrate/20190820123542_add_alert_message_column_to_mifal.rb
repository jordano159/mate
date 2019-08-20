class AddAlertMessageColumnToMifal < ActiveRecord::Migration[5.2]
  def change
    add_column :mifals, :alert_message, :string
  end
end
