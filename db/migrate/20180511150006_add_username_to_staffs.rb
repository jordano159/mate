class AddUsernameToStaffs < ActiveRecord::Migration[5.2]
  def change
    add_column :staffs, :username, :string
    add_index :staffs, :username, unique: true
  end
end
